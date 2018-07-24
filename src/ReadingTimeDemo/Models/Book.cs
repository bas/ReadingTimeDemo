using System.ComponentModel.DataAnnotations;

namespace ReadingTimeDemo.Models
{
    public class Book
    {
        [Required]
        [StringLength(100, MinimumLength = 3)]
        public string Title { get; set; }
        [Required]
        [StringLength(60, MinimumLength = 3)]
        public string Author { get; set; }
        public string Cover { get; set; }

        private String rating;

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

        public Book(string title, string author, string cover, int rating)
        {
            Title = title;
            Author = author;
            Cover = cover;
            Rating = rating;
        }

        public int Rating
        {
            get { return rating; }
            set
            {
                ValidateRating(value);
                rating = value;
            }
        }

        public static double ValidateRating(int input)
        {
            if (input < 0 || input > 5)
            {
                throw new System.ArgumentOutOfRangeException("Rating must be a value between 0 and 5");
            }
            return input;
        }
    }

}
