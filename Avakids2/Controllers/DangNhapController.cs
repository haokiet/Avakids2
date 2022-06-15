using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Avakids2.Models;
using System.Web.Security;
namespace Avakids2.Controllers
{
    public class DangNhapController : Controller
    {
        private AVAKIDEntities2 db = new AVAKIDEntities2();
        public bool CheckUser(string username, string password)
        {
            var kq = db.KhachHangs.Where(x => x.TenDN == username && x.MatKhau == password).ToList();
            if (kq.Count() > 0)
            {
                Session["HoTen"] = kq.First().TenKH;
                Session["ID"] = kq.First().MaKH;
                if (kq.First().Admin == true)
                {
                    Session["Admin"] = kq.First().Admin;
                }
                return true;
            }
            else
            {
                Session["HoTen"] = null;
                return false;
            }
        }
        // GET: DangNhap
        public ActionResult DangNhap()
        {
            return View();
        }
        [HttpPost]

        [ValidateAntiForgeryToken]
        public ActionResult DangNhap(string username, string password)
        {
            if (ModelState.IsValid)
            {
                if (CheckUser(username, password))
                {
                    FormsAuthentication.SetAuthCookie(username, true);
                    return RedirectToAction("Index", "HomePage");
                }
                else
                    ModelState.AddModelError("", "Tên đăng nhập hoặc tài khoản không đúng.");
            }
            var u = new KhachHang();
            u.MatKhau = password;
            u.TenDN = username;
            return View(u);
        }
        public ActionResult Logout()
        {

            //Session.Clear();//remove session

            Session.Remove("HoTen");
            Session.Remove("ID");
            Session.Remove("Admin");
            FormsAuthentication.SignOut();
            return RedirectToAction("DangNhap", "DangNhap");
        }

        // GET: DangNhap/Create
        public ActionResult DangKy()
        {
            return View();
        }

        // POST: DangNhap/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult DangKy([Bind(Include = "MaKH,HoKH,TenKH,SoDT,DiaChi,TenDN,MatKhau")] KhachHang khachHang)
        {
            if (ModelState.IsValid)
            {
                Random rnd = new Random();
                khachHang.MaKH = "KH" + DateTime.Now.ToString("ddMM") + rnd.Next(1, 999);
                db.KhachHangs.Add(khachHang);
                db.SaveChanges();
                return RedirectToAction("DangNhap","DangNhap");
            }

            return View(khachHang);
        }

        // GET: DangNhap/Edit/5

    }
}
