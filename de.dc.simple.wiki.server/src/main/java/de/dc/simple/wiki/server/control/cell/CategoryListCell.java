package de.dc.simple.wiki.server.control.cell;

import de.dc.simple.wiki.server.model.Category;
import javafx.scene.control.ListCell;

public class CategoryListCell extends ListCell<Category>{

	@Override
	protected void updateItem(Category item, boolean empty) {
		super.updateItem(item, empty);
		if (item == null || empty) {
			setText(null);
		} else {
			setText(item.getName());
		}
	}
}
