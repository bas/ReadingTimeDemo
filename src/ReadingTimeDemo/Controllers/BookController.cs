using Microsoft.AspNetCore.Mvc;
using ReadingTimeDemo.Services;

namespace ReadingTimeDemo.Controllers
{
    public class BookController : Controller
    {
        private readonly BookService bookService = new BookService();

        public IActionResult Index()
        {
            return View(bookService.Books());
        }
    }
}
