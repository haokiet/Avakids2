using System;
using System.Collections.Generic;
using System.Linq;
using System.Web;
using System.Web.Mvc;

namespace Avakids2.Controllers
{
    public class Cart : Controller
    {
        public string name, photo, id;
        public int price, quantity;
        public Cart(string id, string name, string photo, int price, int quantity)
        {
            this.id = id;
            this.name = name;
            this.photo = photo;
            this.price = price;
            this.quantity = quantity;
        }
    }
}