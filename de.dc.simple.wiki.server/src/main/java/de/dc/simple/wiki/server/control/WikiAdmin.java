package de.dc.simple.wiki.server.control;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationListener;
import org.springframework.stereotype.Controller;

import de.dc.simple.wiki.server.control.cell.CategoryListCell;
import de.dc.simple.wiki.server.control.converter.CategoryConverter;
import de.dc.simple.wiki.server.event.PageEvent;
import de.dc.simple.wiki.server.model.Category;
import de.dc.simple.wiki.server.model.Page;
import de.dc.simple.wiki.server.model.User;
import de.dc.simple.wiki.server.service.ICategoryService;
import de.dc.simple.wiki.server.service.IPageService;
import de.dc.simple.wiki.server.service.IUserService;
import javafx.application.Platform;
import javafx.beans.binding.Bindings;
import javafx.beans.value.ObservableValue;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.collections.transformation.FilteredList;
import javafx.event.ActionEvent;
import javafx.scene.control.TextInputDialog;
import javafx.scene.control.cell.PropertyValueFactory;
import javafx.scene.input.MouseEvent;

@Controller
public class WikiAdmin extends BaseWikiAdmin implements ApplicationListener<PageEvent> {

	@Autowired IPageService pageService;
	@Autowired ICategoryService categoryService;
	@Autowired IUserService userService;

	ObservableList<Page> masterData = FXCollections.observableArrayList();
	FilteredList<Page> filteredData = new FilteredList<>(masterData);

	ObservableList<Category> masterCategoryData = FXCollections.observableArrayList();
	FilteredList<Category> filteredCategoryData = new FilteredList<>(masterCategoryData);

	ObservableList<User> masterUserData = FXCollections.observableArrayList();
	FilteredList<User> filteredUserData = new FilteredList<>(masterUserData);

	public void initialize() {
		initPaneWiki();
		initPaneUserManagement();
	}

	private void initPaneUserManagement() {
		columnUserActive.setCellValueFactory(new PropertyValueFactory<>("isActive"));
		columnUserCreated.setCellValueFactory(new PropertyValueFactory<>("created"));
		columnUserFirstname.setCellValueFactory(new PropertyValueFactory<>("lastname"));
		columnUserLastname.setCellValueFactory(new PropertyValueFactory<>("firstname"));
		columnUsername.setCellValueFactory(new PropertyValueFactory<>("username"));
		
		masterUserData.addAll(userService.findAll());
		tableViewUser.setItems(filteredUserData);
	}

	private void initPaneWiki() {
		columnContent.setCellValueFactory(new PropertyValueFactory<>("content"));
		columnTitle.setCellValueFactory(new PropertyValueFactory<>("title"));
		columnId.setCellValueFactory(new PropertyValueFactory<>("id"));
		columnCreated.setCellValueFactory(new PropertyValueFactory<>("created"));
		columnUpdated.setCellValueFactory(new PropertyValueFactory<>("updated"));
		columnStatus.setCellValueFactory(new PropertyValueFactory<>("formatStatus"));
		columnCategory.setCellValueFactory(new PropertyValueFactory<>("categoryId"));

		tableView.setItems(filteredData);
		tableView.setFixedCellSize(20.0);

		comboCategory.setCellFactory(e -> new CategoryListCell());
		comboCategory.setConverter(new CategoryConverter());
		comboCategory.setItems(masterCategoryData);

		listViewCategory.setCellFactory(e -> new CategoryListCell());
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

	private void onTextSearchCategoryFilter(ObservableValue<? extends String> observable, String oldValue,
			String newValue) {
		if (newValue != null) {
			filteredCategoryData.setPredicate(e -> {
				return e.getName().toLowerCase().contains(newValue.toLowerCase());
			});
		}
	}

	private void onTextSearchPageFilter(ObservableValue<? extends String> observable, String oldValue,
			String newValue) {
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

	private void onListViewCategoryChanged(ObservableValue<? extends Category> observable, Category oldValue,
			Category newValue) {
		if (newValue != null) {
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

	@Override
	public void onApplicationEvent(PageEvent event) {
		Page page = event.getPage();
		Platform.runLater(()->add(page));
	}

	@Override
	protected void onListViewCategoryClicked(MouseEvent e) {
		Category selection = listViewCategory.getSelectionModel().getSelectedItem();
		if (selection != null) {
			textSearchPages.setText("");
			filteredData.setPredicate(p -> {
				return p.getCategoryId() == selection.getId();
			});
		}
	}

	@Override
	protected void onButtonShowAllAction(ActionEvent event) {
		textSearchPages.setText("");
		filteredData.setPredicate(o-> true);
	}

	@Override
	protected void onButtonCreateNewUser(ActionEvent event) {
		String username = textUsername.getText();
		String firstname = textFirstname.getText();
		String lastname = textLastname.getText();
		String password = textPassword.getText();
		boolean isActive = true;
		User user = userService.create(username, firstname, lastname, password, isActive);
		masterUserData.add(user);
		
		textUsername.setText("");
		textFirstname.setText("");
		textLastname.setText("");
		textPassword.setText("");
	}

	@Override
	protected void onButtonOpenUserManagementAction(ActionEvent event) {
		paneUserManagement.toFront();
	}

	@Override
	protected void onButtonOpenWikiAction(ActionEvent event) {
		paneWiki.toFront();
	}
}
