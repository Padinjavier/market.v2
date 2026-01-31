using Microsoft.AspNetCore.Mvc;
using Microsoft.EntityFrameworkCore;
using market.Data;
using market.Models;
using System.Security.Cryptography;
using System.Text;

namespace market.Controllers
{
    public class AccountController : Controller
    {
        private readonly MarketContext _context;

        public AccountController(MarketContext context)
        {
            _context = context;
        }

        [HttpGet]
        public IActionResult Login()
        {
            return PartialView("_LoginModal");
        }

        [HttpPost]
        public async Task<IActionResult> Login(string email, string password)
        {
            if (string.IsNullOrEmpty(email) || string.IsNullOrEmpty(password))
            {
                TempData["Error"] = "Correo y contraseña son requeridos.";
                return RedirectToAction("Index", "Home");
            }

            var hashedPassword = HashPassword(password);

            // 1) Intentar con la nueva tabla `users`
            var user = await _context.Set<User>()
                .FirstOrDefaultAsync(u => u.Email == email && u.PasswordHash == hashedPassword && u.Status == 1);

            Persona personaFallback = null;
            if (user == null)
            {
                // 2) Fallback a personas (compatibilidad hacia atrás)
                personaFallback = await _context.Personas
                    .FirstOrDefaultAsync(p => p.EmailUser == email && p.Password == hashedPassword && p.Status == 1);

                if (personaFallback == null)
                {
                    TempData["Error"] = "Correo o contraseña incorrectos.";
                    return RedirectToAction("Index", "Home");
                }
            }

            // Normalizar datos de usuario (soporta ambos esquemas)
            var sessionUserId = user != null ? user.UserId.ToString() : personaFallback!.Idpersona.ToString();
            var identification = user?.Identification ?? personaFallback?.Identificacion ?? string.Empty;

            // nombres/apellidos: separar por espacios para extraer primer y segundo nombre si no hay campos separados
            string firstName = string.Empty, middleName = string.Empty, lastName = string.Empty, secondLastName = string.Empty;
            if (user != null)
            {
                firstName = user.FirstName ?? string.Empty;
                middleName = user.MiddleName ?? string.Empty;
                lastName = user.LastName ?? string.Empty;
                secondLastName = user.SecondLastName ?? string.Empty;
            }
            else
            {
                var nombres = (personaFallback!.Nombres ?? string.Empty).Split(' ', StringSplitOptions.RemoveEmptyEntries);
                firstName = nombres.Length > 0 ? nombres[0] : string.Empty;
                middleName = nombres.Length > 1 ? nombres[1] : string.Empty;

                var apellidos = (personaFallback.Apellidos ?? string.Empty).Split(' ', StringSplitOptions.RemoveEmptyEntries);
                lastName = apellidos.Length > 0 ? apellidos[0] : string.Empty;
                secondLastName = apellidos.Length > 1 ? apellidos[1] : string.Empty;
            }

            var phone = user != null ? user.Phone : personaFallback!.Telefono.ToString();
            var emailStored = user != null ? user.Email : personaFallback!.EmailUser;
            var roleId = user != null ? user.RoleId.ToString() : personaFallback!.Rolid.ToString();

            // Guardar en sesión (campos solicitados)
            HttpContext.Session.SetString("UserId", sessionUserId);
            HttpContext.Session.SetString("Identification", identification ?? string.Empty);
            HttpContext.Session.SetString("FirstName", firstName ?? string.Empty);
            HttpContext.Session.SetString("MiddleName", middleName ?? string.Empty);
            HttpContext.Session.SetString("LastName", lastName ?? string.Empty);
            HttpContext.Session.SetString("SecondLastName", secondLastName ?? string.Empty);
            HttpContext.Session.SetString("Phone", phone ?? string.Empty);
            HttpContext.Session.SetString("Email", emailStored ?? string.Empty);
            HttpContext.Session.SetString("RoleId", roleId ?? string.Empty);

            // Compatibilidad con keys usadas antes
            HttpContext.Session.SetString("UserName", (firstName ?? string.Empty));
            HttpContext.Session.SetString("UserRole", roleId ?? string.Empty);

            // Construir permisos escalables desde tablas `permissions` + `modules`
            var perms = await (from p in _context.Permissions
                               join m in _context.Modules on p.ModuleId equals m.ModuleId
                               where p.RoleId == (user != null ? user.RoleId : personaFallback!.Rolid)
                               select new
                               {
                                   Module = m.Title,
                                   p.CanRead,
                                   p.CanWrite,
                                   p.CanUpdate,
                                   p.CanDelete
                               }).ToListAsync();

            var dict = perms
                .GroupBy(x => (x.Module ?? string.Empty).ToLowerInvariant())
                .ToDictionary(g => g.Key, g => new Helpers.PermissionDto
                {
                    Read = g.First().CanRead == 1,
                    Write = g.First().CanWrite == 1,
                    Update = g.First().CanUpdate == 1,
                    Delete = g.First().CanDelete == 1
                });

            // Guardar permisos en sesión (JSON) — usar SessionExtensions
            HttpContext.Session.SetObject("Permissions", dict);

            return RedirectToAction("Index", "Home");
        }

        [HttpPost]
        public IActionResult Logout()
        {
            HttpContext.Session.Clear();
            return RedirectToAction("Index", "Home");
        }

        private string HashPassword(string password)
        {
            using (var sha256 = SHA256.Create())
            {
                var bytes = Encoding.UTF8.GetBytes(password);
                var hash = sha256.ComputeHash(bytes);
                return BitConverter.ToString(hash).Replace("-", "").ToLower();
            }
        }

    }
}