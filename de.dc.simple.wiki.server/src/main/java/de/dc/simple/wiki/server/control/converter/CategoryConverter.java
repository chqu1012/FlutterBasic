package de.dc.simple.wiki.server.control.converter;

import de.dc.simple.wiki.server.model.Category;
import javafx.util.StringConverter;

public class CategoryConverter extends StringConverter<Category>{

	@Override
	public String toString(Category object) {
		return object.getName();
	}
	
	@Override
	public Category fromString(String name) {
		Category category = new Category();
		category.setName(name);
		return category;
	}
}
