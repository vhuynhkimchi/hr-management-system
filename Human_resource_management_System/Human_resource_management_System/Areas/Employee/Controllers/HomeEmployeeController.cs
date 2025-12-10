using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Human_resource_management_System.Areas.Employee.Controllers
{
    public class HomeEmployeeController : Controller
    {
        // GET: Employee/HomeEmployee
        public ActionResult Index()
        {
            return View();
        }
    }
}