package de.dc.simple.wiki.server.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import de.dc.simple.wiki.server.model.Category;
import de.dc.simple.wiki.server.repository.CategoryRepository;

@Service
public class CategoryService implements ICategoryService{

	@Autowired CategoryRepository categoryRepository;
	
	@Override
	public Category create(String name) {
		Category category = new Category();
		category.setCreated(LocalDateTime.now());
		category.setUpdated(LocalDateTime.now());
		category.setName(name);
		return categoryRepository.save(category);
	}

	@Override
	public List<Category> findAll() {
		return categoryRepository.findAll();
	}

}
