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
            Console.WriteLine($"Email: {email}, Hashed Password: {hashedPassword}");

            var persona = await _context.Personas
                .FirstOrDefaultAsync(p => p.EmailUser == email && p.Password == hashedPassword && p.Status == 1);

            if (persona == null)
            {
                Console.WriteLine("Usuario no encontrado o contraseña incorrecta.");
                TempData["Error"] = "Correo o contraseña incorrectos.";
                return RedirectToAction("Index", "Home");
            }

            // Guardar en sesión
            HttpContext.Session.SetString("UserId", persona.Idpersona.ToString());
            HttpContext.Session.SetString("UserName", persona.Nombres.Split(' ')[0]); // Primer nombre
            HttpContext.Session.SetString("UserRole", persona.Rolid.ToString());

            Console.WriteLine($"Login exitoso para {persona.Nombres}");

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
            using (var sha1 = SHA1.Create())
            {
                var bytes = Encoding.UTF8.GetBytes(password);
                var hash = sha1.ComputeHash(bytes);
                return BitConverter.ToString(hash).Replace("-", "").ToLower();
            }
        }
    }
}