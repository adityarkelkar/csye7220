package com.lms.controller;

import java.util.List;

import javax.validation.Valid;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import com.lms.model.Book;
import com.lms.repository.BookRepository;

@RestController
@RequestMapping("/library")
public class BookController {
	@Autowired
	BookRepository bookRepo;
	
	// Simple request
	@GetMapping("/")
	public String mainHit() {
		return "You hit blah";
	}
	
	// Get all books
	@GetMapping("/books")
	public List<Book> getAllBooks() {
		return bookRepo.findAll();
	}
	
	// Add book
	@PostMapping("/book/add")
	public Book addBook(@Valid @RequestBody Book book) {
		System.out.println("SAVING BOOK ");
		return bookRepo.save(book);
	}
	
	
}
