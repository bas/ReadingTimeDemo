using Microsoft.AspNetCore.Mvc;
using ReadingTimeDemo.Services;

namespace ReadingTimeDemo.Controllers
{
    public class BookController : Controller
    {
        private BookService bookService = new BookService();

        public IActionResult Index()
        {
            return View(bookService.Books());
        }
    }
}
