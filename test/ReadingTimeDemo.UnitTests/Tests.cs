using Xunit;
using ReadingTimeDemo.Models;
using ReadingTimeDemo.Services;
using System.ComponentModel.DataAnnotations;
using System.Collections.Generic;
using ReadingTimeDemo.Controllers;
using Microsoft.AspNetCore.Mvc;
using Microsoft.AspNetCore.Mvc.ViewFeatures;
using System;
using System.Linq;

namespace Tests
{
    public class Tests
    {
        [Fact]
        public void TestEmptyBookConstructor()
        {
            Book book = new Book();
            Assert.NotNull(book);
        }

        [Fact]
        public void TestBookConstructor()
        {
            Book book = new Book("Crossing the Chasm", "Geoffrey A.Moore");
            Assert.Equal("Geoffrey A.Moore", book.Author);
            Assert.Equal("Crossing the Chasm", book.Title);
        }

        [Fact]
        public void ConstructorWithCoverTest()
        {
            Book book = new Book("Crossing the Chasm", "Geoffrey A.Moore", "cover.jpg");
            Assert.Equal("cover.jpg", book.Cover);
        }

        [Fact]
        public void ExpectValidBookModelState()
        {
            Book book = new Book("Crossing the Chasm", "Geoffrey A.Moore");
            var context = new ValidationContext(book, null, null);
            var result = new List<ValidationResult>();

            var valid = Validator.TryValidateObject(book, context, result, true);

            Assert.True(valid);

        }

        [Theory]
        [InlineData("a")]
        [InlineData("ab")]
        [InlineData("ababababababababababababababababababababababababababababababa")]
        public void ExpectInvalidBookAuthorModelState(string author)
        {
            Book book = new Book("Crossing the Chasm", author);
            var context = new ValidationContext(book, null, null);
            var result = new List<ValidationResult>();

            var valid = Validator.TryValidateObject(book, context, result, true);

            Assert.False(valid);

        }

        [Theory]
        [InlineData("a")]
        [InlineData("ab")]
        public void ExpectInvalidBookTitleModelState(string title)
        {
            Book book = new Book(title, "Geoffrey A.Moore");
            var context = new ValidationContext(book, null, null);
            var result = new List<ValidationResult>();

            var valid = Validator.TryValidateObject(book, context, result, true);

            Assert.False(valid);

        }

        [Fact]
        public void BookServiceCountTest()
        {
            BookService bookService = new BookService();
            Assert.Equal(4, bookService.Books().Count);
        }

        [Fact]
        public void HomeControllerIndexViewTest()
        {
            var controller = new HomeController();

            var result = controller.Index();

            var viewResult = Assert.IsType<ViewResult>(result);

        }

        [Fact]
        public void HomeControllerAboutViewTest()
        {
            var controller = new HomeController();

            var result = controller.About();

            var viewResult = Assert.IsType<ViewResult>(result);

            ViewDataDictionary viewData = viewResult.ViewData;
            Assert.Equal("Your application description page.", viewData["Message"]);

        }

        [Fact]
        public void HomeControllerContactViewTest()
        {
            var controller = new HomeController();

            var result = controller.Contact();

            var viewResult = Assert.IsType<ViewResult>(result);

            ViewDataDictionary viewData = viewResult.ViewData;
            Assert.Equal("Your contact page.", viewData["Message"]);

        }

        [Theory]
        [InlineData(0)]
        [InlineData(1)]
        [InlineData(2)]
        [InlineData(3)]
        [InlineData(4)]
        [InlineData(5)]
        public void ValidRatingTest(int rating)
        {
            Book book = new Book("Crossing the Chasm", "Geoffrey A. Moore");
            book.Rating = rating;
            Assert.Equal(rating, book.Rating);
        }

        [Theory]
        [InlineData(-1)]
        [InlineData(6)]
        public void InvalidRatingTest(int rating)
        {
            Book book = new Book("Crossing the Chasm", "Geoffrey A. Moore");

            Exception ex = Record.Exception(() => book.Rating = rating);

            Assert.IsType<ArgumentOutOfRangeException>(ex);
        }

        [Fact]
        public void BookControllerViewAndModelTest()
        {
            var controller = new BookController();

            var result = controller.Index();

            var viewResult = Assert.IsType<ViewResult>(result);

            var books = Assert.IsAssignableFrom<IEnumerable<Book>>(
                viewResult.ViewData.Model);
            Assert.Equal(4, books.Count());
        }

    }
}
