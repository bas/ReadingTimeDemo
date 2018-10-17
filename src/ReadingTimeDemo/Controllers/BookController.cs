using Microsoft.AspNetCore.Mvc;
using ReadingTimeDemo.Services;

// For more information on enabling MVC for empty projects, visit http://go.microsoft.com/fwlink/?LinkID=397860

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
