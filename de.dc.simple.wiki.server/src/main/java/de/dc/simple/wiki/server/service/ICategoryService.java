package de.dc.simple.wiki.server.service;

import java.util.List;

import de.dc.simple.wiki.server.model.Category;

public interface ICategoryService {

	Category create(String name);
	
	List<Category> findAll();
}
