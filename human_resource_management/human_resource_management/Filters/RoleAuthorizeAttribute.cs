using System.Linq;
using System.Web;
using System.Web.Mvc;
using System.Web.Routing;
using System.Web.Security;

namespace human_resource_management.Filters
{
    public class RoleAuthorizeAttribute : AuthorizeAttribute
    {
        public string[] AllowedRoles { get; set; }

        public RoleAuthorizeAttribute(params string[] roles)
        {
            AllowedRoles = roles;
        }

        protected override bool AuthorizeCore(HttpContextBase httpContext)
        {
            if (!httpContext.Request.IsAuthenticated)
            {
                return false;
            }

            // Lấy vai trò từ Session và xóa khoảng trắng thừa
            var userRole = httpContext.Session["UserRole"]?.ToString()?.Trim();

            if (string.IsNullOrEmpty(userRole))
            {
                return false;
            }

            // Kiểm tra xem vai trò của người dùng có thuộc danh sách được phép hay không (so sánh không phân biệt hoa thường)
            return AllowedRoles.Any(role => role.Trim().Equals(userRole, System.StringComparison.OrdinalIgnoreCase));
        }

        protected override void HandleUnauthorizedRequest(AuthorizationContext filterContext)
        {
            if (!filterContext.HttpContext.Request.IsAuthenticated)
            {
                // Người dùng chưa xác thực (chưa đăng nhập), chuyển hướng về trang đăng nhập
                filterContext.Result = new RedirectToRouteResult(
                    new RouteValueDictionary(new { controller = "Account", action = "Login", area = "" })
                );
            }
            else
            {
                // Người dùng đã đăng nhập nhưng không đủ quyền truy cập vào chức năng này
                // Chuyển hướng người dùng về trang chủ tương ứng với vai trò của họ
                var userRole = filterContext.HttpContext.Session["UserRole"]?.ToString()?.Trim();

                switch (userRole)
                {
                    case "Admin":
                        filterContext.Result = new RedirectToRouteResult(
                            new RouteValueDictionary(new { controller = "Home", action = "Index", area = "Admin" })
                        );
                        break;
                    case "Nhân sự":
                        filterContext.Result = new RedirectToRouteResult(
                            new RouteValueDictionary(new { controller = "Home", action = "Index", area = "HumanResource" })
                        );
                        break;
                    case "Nhân viên":
                        filterContext.Result = new RedirectToRouteResult(
                            new RouteValueDictionary(new { controller = "Home", action = "Index", area = "Employee" })
                        );
                        break;
                    default:
                        filterContext.Result = new RedirectToRouteResult(
                            new RouteValueDictionary(new { controller = "Account", action = "Login", area = "" })
                        );
                        break;
                }
            }
        }
    }
}
