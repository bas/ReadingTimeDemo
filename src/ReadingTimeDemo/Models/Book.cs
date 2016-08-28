using System.ComponentModel.DataAnnotations;

namespace ReadingTimeDemo.Models
{
    public class Book
    {
        [Required]
        public string Title { get; set; }
        public string Author { get; set; }
        public string Cover { get; set; }

        public Book()
        {

        }

        public Book(string title, string author)
        {
            Title = title;
            Author = author;
        }
        public Book(string title, string author, string cover)
        {
            Title = title;
            Author = author;
            Cover = cover;
        }
    }

}
