package de.dc.simple.wiki.server.control;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import de.dc.simple.wiki.server.control.cell.CategoryListCell;
import de.dc.simple.wiki.server.control.converter.CategoryConverter;
import de.dc.simple.wiki.server.model.Category;
import de.dc.simple.wiki.server.model.Page;
import de.dc.simple.wiki.server.service.ICategoryService;
import de.dc.simple.wiki.server.service.IPageService;
import javafx.beans.binding.Bindings;
import javafx.beans.value.ObservableValue;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.collections.transformation.FilteredList;
import javafx.event.ActionEvent;
import javafx.scene.control.TextInputDialog;
import javafx.scene.control.cell.PropertyValueFactory;

@Controller
public class WikiAdmin extends BaseWikiAdmin {

	@Autowired IPageService pageService;
	@Autowired ICategoryService categoryService;

	ObservableList<Page> masterData = FXCollections.observableArrayList();
	FilteredList<Page> filteredData = new FilteredList<>(masterData);

	ObservableList<Category> masterCategoryData = FXCollections.observableArrayList();
	FilteredList<Category> filteredCategoryData = new FilteredList<>(masterCategoryData);

	public void initialize() {
		columnContent.setCellValueFactory(new PropertyValueFactory<>("content"));
		columnTitle.setCellValueFactory(new PropertyValueFactory<>("title"));
		columnId.setCellValueFactory(new PropertyValueFactory<>("id"));
		columnCreated.setCellValueFactory(new PropertyValueFactory<>("created"));
		columnUpdated.setCellValueFactory(new PropertyValueFactory<>("updated"));
		columnStatus.setCellValueFactory(new PropertyValueFactory<>("formatStatus"));

		tableView.setItems(filteredData);
		tableView.setFixedCellSize(20.0);

		comboCategory.setCellFactory(e-> new CategoryListCell());
		comboCategory.setConverter(new CategoryConverter());
		comboCategory.setItems(masterCategoryData);
		
		listViewCategory.setCellFactory(e-> new CategoryListCell());
		listViewCategory.setItems(filteredCategoryData);
		
		listViewCategory.getSelectionModel().selectedItemProperty().addListener(this::onListViewCategoryChanged);
		
		masterData.addAll(pageService.findAll());
		masterCategoryData.addAll(categoryService.findAll());
		
		labelPages.textProperty().bind(Bindings.size(masterData).asString());

		textSearchPages.textProperty().addListener(this::onTextSearchPageFilter);
		textSearchCategory.textProperty().addListener(this::onTextSearchCategoryFilter);
	}

	public void add(Page page) {
		masterData.add(page);
	}
	
	private void onTextSearchCategoryFilter(ObservableValue<? extends String> observable, String oldValue, String newValue) {
		if (newValue != null) {
			filteredCategoryData.setPredicate(e -> {
				return e.getName().toLowerCase().contains(newValue.toLowerCase());
			});
		}
	}
	
	private void onTextSearchPageFilter(ObservableValue<? extends String> observable, String oldValue, String newValue) {
		if (newValue != null) {
			filteredData.setPredicate(e -> {
				boolean containsContent = e.getContent().toLowerCase().contains(newValue.toLowerCase());
				boolean containsTitle = e.getTitle().toLowerCase().contains(newValue.toLowerCase());
				boolean containsStatus = e.getFormatStatus().toLowerCase().contains(newValue.toLowerCase());
				boolean containsCreated = e.getCreated().toString().contains(newValue.toLowerCase());
				boolean containsUpdated = e.getUpdated().toString().contains(newValue.toLowerCase());
				return containsUpdated || containsCreated || containsContent || containsTitle || containsStatus;
			});
		}
	}
	
	private void onListViewCategoryChanged(ObservableValue<? extends Category> observable, Category oldValue, Category newValue) {
		if(newValue!=null) {
			comboCategory.getSelectionModel().select(newValue);
		}
	}
	
	@Override
	protected void onButtonCreateAction(ActionEvent event) {
		String title = textTitle.getText();
		String content = textContent.getText();
		Long categoryId = comboCategory.getSelectionModel().getSelectedItem().getId();
		Page newPage = pageService.create(title, content, categoryId);
		masterData.add(newPage);

		textTitle.setText("");
		textContent.setText("");
	}

	@Override
	protected void onMenuItemDeleteCategory(ActionEvent event) {
		// TODO Auto-generated method stub

	}

	@Override
	protected void onMenuItemEditCategory(ActionEvent event) {
		// TODO Auto-generated method stub

	}

	@Override
	protected void onMenuItemNewCategory(ActionEvent event) {
		TextInputDialog dialog = new TextInputDialog("NewCatgeory*");

		dialog.setTitle("New Category");
		dialog.setHeaderText("Enter a category name:");
		dialog.setContentText("Name:");

		Optional<String> result = dialog.showAndWait();

		result.ifPresent(name -> {
			Category category = categoryService.create(name);
			masterCategoryData.add(category);
		});
	}
}
