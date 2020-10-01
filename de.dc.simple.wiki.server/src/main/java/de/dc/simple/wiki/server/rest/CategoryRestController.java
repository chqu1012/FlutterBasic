package de.dc.simple.wiki.server.rest;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

import de.dc.simple.wiki.server.model.Category;
import de.dc.simple.wiki.server.repository.CategoryRepository;

@RestController
public class CategoryRestController {

	@Autowired CategoryRepository categoryRepository;
	
	@GetMapping("/categories")
	public List<Category> findAll() {
		return categoryRepository.findAll();
	}
}
