using System;
using System.Collections.Generic;
using System.Data;
using System.Data.Entity;
using System.Linq;
using System.Net;
using System.Web;
using System.Web.Mvc;
using Avakids2.Models;

namespace Avakids2.Controllers
{
    public class CTHoaDonsController : Controller
    {
        private AVAKIDEntities2 db = new AVAKIDEntities2();

        // GET: CTHoaDons
        public ActionResult Index()
        {
            var cTHoaDons = db.CTHoaDons.Include(c => c.HoaDon).Include(c => c.SanPham);
            if (Session["HoTen"] == null && Session["Admin"] == null)
            {
                return RedirectToAction("DangNhap", "DangNhap");
            }
            else
                return View(cTHoaDons.ToList());
        }

        // GET: CTHoaDons/Details/5
        public ActionResult Details(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            CTHoaDon cTHoaDon = db.CTHoaDons.Find(id);
            if (cTHoaDon == null)
            {
                return HttpNotFound();
            }
            return View(cTHoaDon);
        }

        // GET: CTHoaDons/Create
        public ActionResult Create()
        {
            ViewBag.SoHD = new SelectList(db.HoaDons, "SoHD", "MaKH");
            ViewBag.SoHD = new SelectList(db.SanPhams, "MaSP", "MaHang");
            return View();
        }

        // POST: CTHoaDons/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "SoHD,MaSP,SoLuong,DonGia")] CTHoaDon cTHoaDon)
        {
            if (ModelState.IsValid)
            {
                db.CTHoaDons.Add(cTHoaDon);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.SoHD = new SelectList(db.HoaDons, "SoHD", "MaKH", cTHoaDon.SoHD);
            ViewBag.SoHD = new SelectList(db.SanPhams, "MaSP", "MaHang", cTHoaDon.SoHD);
            return View(cTHoaDon);
        }

        // GET: CTHoaDons/Edit/5
        public ActionResult Edit(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            CTHoaDon cTHoaDon = db.CTHoaDons.Find(id);
            if (cTHoaDon == null)
            {
                return HttpNotFound();
            }
            ViewBag.SoHD = new SelectList(db.HoaDons, "SoHD", "MaKH", cTHoaDon.SoHD);
            ViewBag.SoHD = new SelectList(db.SanPhams, "MaSP", "MaHang", cTHoaDon.SoHD);
            return View(cTHoaDon);
        }

        // POST: CTHoaDons/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "SoHD,MaSP,SoLuong,DonGia")] CTHoaDon cTHoaDon)
        {
            if (ModelState.IsValid)
            {
                db.Entry(cTHoaDon).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.SoHD = new SelectList(db.HoaDons, "SoHD", "MaKH", cTHoaDon.SoHD);
            ViewBag.SoHD = new SelectList(db.SanPhams, "MaSP", "MaHang", cTHoaDon.SoHD);
            return View(cTHoaDon);
        }

        // GET: CTHoaDons/Delete/5
        public ActionResult Delete(string id)
        {
            if (id == null)
            {
                return new HttpStatusCodeResult(HttpStatusCode.BadRequest);
            }
            CTHoaDon cTHoaDon = db.CTHoaDons.Find(id);
            if (cTHoaDon == null)
            {
                return HttpNotFound();
            }
            return View(cTHoaDon);
        }

        // POST: CTHoaDons/Delete/5
        [HttpPost, ActionName("Delete")]
        [ValidateAntiForgeryToken]
        public ActionResult DeleteConfirmed(string id)
        {
            CTHoaDon cTHoaDon = db.CTHoaDons.Find(id);
            db.CTHoaDons.Remove(cTHoaDon);
            db.SaveChanges();
            return RedirectToAction("Index");
        }

        protected override void Dispose(bool disposing)
        {
            if (disposing)
            {
                db.Dispose();
            }
            base.Dispose(disposing);
        }
    }
}
