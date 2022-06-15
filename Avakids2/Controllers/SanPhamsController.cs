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
    public class SanPhamsController : Controller
    {
        private AVAKIDEntities2 db = new AVAKIDEntities2();

        // GET: SanPhams
        public ActionResult Index()
        {
            var sanPhams = db.SanPhams.Include(s => s.Hang).Include(s => s.Nganh);
            if (Session["Admin"] == null)
            {
                return RedirectToAction("DangNhap", "DangNhap");
            }
            else
                return View(sanPhams.ToList());
        }

        // GET: SanPhams/Details/5
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

        // GET: SanPhams/Create
        public ActionResult Create()
        {
            if (Session["Admin"] == null)
            {
                return RedirectToAction("DangNhap", "DangNhap");
            }
            else
                ViewBag.MaHang = new SelectList(db.Hangs, "MaHang", "TenHang");
                ViewBag.MaNganh = new SelectList(db.Nganhs, "MaNganh", "TenNganh");
                return View();
        }

        // POST: SanPhams/Create
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Create([Bind(Include = "MaSP,MaHang,MaNganh,TenSP,MoTaSP,AnhSP,Dongia,DonViTinh,SoLuong")] SanPham sanPham)
        {
            var imgNV = Request.Files["Avatar"];
            //Lấy thông tin từ input type=file có tên Avatar
            string postedFileName = System.IO.Path.GetFileName(imgNV.FileName);
            //Lưu hình đại diện về Server
            var path = Server.MapPath("/ProductImages/" + postedFileName);
            imgNV.SaveAs(path);

            if (ModelState.IsValid)
            {
                sanPham.AnhSP = postedFileName;
                db.SanPhams.Add(sanPham);
                db.SaveChanges();
                return RedirectToAction("Index");
            }

            ViewBag.MaHang = new SelectList(db.Hangs, "MaHang", "TenHang", sanPham.MaHang);
            ViewBag.MaNganh = new SelectList(db.Nganhs, "MaNganh", "TenNganh", sanPham.MaNganh);
            return View(sanPham);
        }
        [HttpGet]

        public ActionResult TimKiem_SanPham(string maSP = "", string tenSP = "")
        {
            ViewBag.maSP = maSP;
            ViewBag.tenSP = tenSP;

            var SP = db.SanPhams.SqlQuery("SANPHAM_TimKiem'" + maSP + "',N'" + tenSP + "'");
            if (SP.Count() == 0)
                ViewBag.TB = "Không có thông tin tìm kiếm.";
            return View(SP.ToList());
        }

        // GET: SanPhams/Edit/5
        public ActionResult Edit(string id)
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
            ViewBag.MaHang = new SelectList(db.Hangs, "MaHang", "TenHang", sanPham.MaHang);
            ViewBag.MaNganh = new SelectList(db.Nganhs, "MaNganh", "TenNganh", sanPham.MaNganh);
            return View(sanPham);
        }

        // POST: SanPhams/Edit/5
        // To protect from overposting attacks, enable the specific properties you want to bind to, for 
        // more details see https://go.microsoft.com/fwlink/?LinkId=317598.
        [HttpPost]
        [ValidateAntiForgeryToken]
        public ActionResult Edit([Bind(Include = "MaSP,MaHang,MaNganh,TenSP,MoTaSP,AnhSP,Dongia,DonViTinh,SoLuong")] SanPham sanPham)
        {
            var imgNV = Request.Files["Avatar"];
            try
            {
                //Lấy thông tin từ input type=file có tên Avatar
                string postedFileName = System.IO.Path.GetFileName(imgNV.FileName);
                //Lưu hình đại diện về Server
                var path = Server.MapPath("/ProductImages/" + postedFileName);
                imgNV.SaveAs(path);
            }
            catch
            { }
            if (ModelState.IsValid)
            {
                db.Entry(sanPham).State = EntityState.Modified;
                db.SaveChanges();
                return RedirectToAction("Index");
            }
            ViewBag.MaHang = new SelectList(db.Hangs, "MaHang", "TenHang", sanPham.MaHang);
            ViewBag.MaNganh = new SelectList(db.Nganhs, "MaNganh", "TenNganh", sanPham.MaNganh);
            return View(sanPham);
        }

        // GET: SanPhams/Delete/5
        public ActionResult Delete(string id)
        {
           
            SanPham sanPham = db.SanPhams.Find(id);
            db.SanPhams.Remove(sanPham);
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
