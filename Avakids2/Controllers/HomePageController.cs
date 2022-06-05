using System;
using System.Collections.Generic;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Avakids2.Models;
namespace Avakids2.Controllers
{
    public class HomePageController : Controller
    {
        private AVAKIDEntities2 db = new AVAKIDEntities2();
        // GET: HomePage
        public ActionResult Index()
        {
            return View(db.SanPhams.ToList());
        }

        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            SanPham sanPham = db.SanPhams.Find(id);
            if (sanPham == null)
            {
                return HttpNotFound();
            }
            return View(sanPham);
        }
    }
}