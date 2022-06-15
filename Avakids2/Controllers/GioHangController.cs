using Avakids2.Models;
using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Avakids2.Controllers
{
    public class GioHangController : Controller
    {
        private AVAKIDEntities2 db = new AVAKIDEntities2();
        // GET: GioHang
        private const string CartSession = "CartSesion";
        public ActionResult Index()
        {
            if (Session["HoTen"] == null && Session["Admin"] == null)
            {
                return RedirectToAction("DangNhap", "DangNhap");
            }

            var cart = Session[CartSession];
            var list = new List<Cart>();
            if (cart != null)
            {
                list = (List<Cart>)cart;
            }

            var id = Session["ID"];
            var temp = db.KhachHangs.Find(id);

            if (temp != null)
            {
                ViewBag.name = temp.HoKH + " " + temp.TenKH;
                ViewBag.address = temp.DiaChi;
                ViewBag.phone = temp.SoDT;
            }

            return View(list);
        }
        public ActionResult AddToCart(string id)
        {
            if (Session["ID"] == null || Session["ID"].ToString() == "")
            {
                return RedirectToAction("DangNhap", "DangNhap");

            }
            var cart = Session[CartSession];
            var temp = db.SanPhams.Find(id);

            if (cart != null)
            {
                // lấy giá trị của sesion
                List<Cart> list = (List<Cart>)cart;
                // tìm kiếm
                if (list.Exists(x => x.id == id))
                {
                    // tăng lên 1 đơn vị
                    foreach (var item in list)
                    {
                        if (item.id == id)
                        {
                            item.quantity++;
                        }
                    }
                }
                else
                {
                    // nếu tìm k ra thì add mới vào
                    Cart c = new Cart(temp.MaSP, temp.TenSP, temp.AnhSP, (int)temp.Dongia, 1);
                    list.Add(c);
                }
                Session[CartSession] = list;
            }
            else
            {
                // chưa có thì tạo ra giỏ hàng 
                Cart c = new Cart(temp.MaSP, temp.TenSP, temp.AnhSP, (int)temp.Dongia, 1);
                List<Cart> list = new List<Cart>();

                // thêm hàng 
                list.Add(c);

                // gán lại sesion
                Session[CartSession] = list;
            }

            return RedirectToAction("Index", "HomePage", db.SanPhams);
        }
        public ActionResult addQuantity(string id, string a)
        {

            var cart = Session[CartSession];

            // lấy giá trị của sesion
            List<Cart> list = (List<Cart>)cart;


            // tìm kiếm
            if (list.Exists(x => x.id == id))
            {
                // tăng lên 1 đơn vị
                foreach (var item in list)
                {
                    if (item.id == id)
                    {
                        item.quantity = a == "+" ? item.quantity + 1 : item.quantity - 1;
                    }
                    if (item.quantity == 0)
                    {
                        list.Remove(item);
                        return RedirectToAction("Index", list);
                    }
                }
            }
            Session[CartSession] = list;
            return RedirectToAction("Index", list);
        }
        public ActionResult removeEach(string id)
        {
            var cart = Session[CartSession];

            // lấy giá trị của sesion
            List<Cart> list = (List<Cart>)cart;

            if (list.Exists(x => x.id == id))
            {
                // tăng lên 1 đơn vị
                foreach (var item in list)
                {
                    if (item.id == id)
                    {
                        list.Remove(item);
                        return RedirectToAction("Index", list);
                    }
                }
            }
            Session[CartSession] = list;


            return RedirectToAction("Index", list);
        }
        public ActionResult RemoveAll()
        {
            Session.Remove(CartSession);
            var cart = Session[CartSession];

            List<Cart> list = (List<Cart>)cart;

            return RedirectToAction("Index", list);
        }

        [HttpGet]
        public ActionResult Order(string address)
        {
            if (Session["ID"] == null || Session["ID"].ToString() == "")
            {
                return RedirectToAction("DangNhap", "DangNhap");
            }

            var cart = Session[CartSession];
            var list = new List<Cart>();
            if (cart != null)
            {
                // tổng tiền
                //int sum = 0;

                // lấy sesion
                list = (List<Cart>)cart;

                // thêm Hóa Đơn
                HoaDon hoaDon = new HoaDon();
                Random rnd = new Random();
                hoaDon.SoHD = DateTime.Now.ToString("ddMM") + rnd.Next(1, 999);
                hoaDon.MaKH = Session["ID"].ToString();
                hoaDon.NgayDatHang = DateTime.Now;
                hoaDon.DiaChiGiaoHang = address;
                hoaDon.TinhTrang = "Chờ xác nhận";
                //foreach (var item in list)
                //{
                //    sum += item.price * item.quantity;
                //}

                db.HoaDons.Add(hoaDon);
                db.SaveChanges();
                //thêm chi tiết hóa đơn

                foreach (var item in list)
                {
                    CTHoaDon cthd = new CTHoaDon();
                    cthd.SoHD = hoaDon.SoHD;
                    cthd.MaSP = item.id;
                    cthd.SoLuong = item.quantity;
                    cthd.DonGia = item.price;
                    db.CTHoaDons.Add(cthd);
                }
                db.SaveChanges();
                return RedirectToAction("OrderSuscess", "GioHang");
            }
            return View(db.HoaDons.ToList());
        }
        public ActionResult OrderSuscess()
        {
            return View();
        }
    }
}