using Microsoft.AspNetCore.Http;
using System.Text.Json;
using market.Models;

namespace market.Helpers
{
    public class PermissionDto
    {
        public bool Read { get; set; }
        public bool Write { get; set; }
        public bool Update { get; set; }
        public bool Delete { get; set; }
    }

    public static class SessionExtensions
    {
        public static void SetObject<T>(this ISession session, string key, T value)
        {
            session.SetString(key, JsonSerializer.Serialize(value));
        }

        public static T? GetObject<T>(this ISession session, string key)
        {
            var str = session.GetString(key);
            return str == null ? default : JsonSerializer.Deserialize<T>(str);
        }
    }

    public static class PermissionHelper
    {
        // devuelve diccionario: moduleTitle(lower) -> PermissionDto
        public static IDictionary<string, PermissionDto> GetPermissions(HttpContext ctx)
        {
            var perms = ctx.Session.GetObject<Dictionary<string, PermissionDto>>("Permissions");
            return perms ?? new Dictionary<string, PermissionDto>();
        }

        // action: "read" | "write" | "update" | "delete"
        public static bool HasPermission(HttpContext ctx, string moduleTitle, string action)
        {
            if (ctx == null) return false;
            var perms = GetPermissions(ctx);
            if (!perms.TryGetValue(moduleTitle.ToLowerInvariant(), out var p)) return false;

            return action.ToLowerInvariant() switch
            {
                "read" => p.Read,
                "write" => p.Write,
                "update" => p.Update,
                "delete" => p.Delete,
                _ => false,
            };
        }
    }
}