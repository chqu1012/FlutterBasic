package de.dc.simple.wiki.server.control;

import java.time.LocalDateTime;

import de.dc.simple.wiki.server.model.Category;
import de.dc.simple.wiki.server.model.Page;
import de.dc.simple.wiki.server.model.User;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.ComboBox;
import javafx.scene.control.Label;
import javafx.scene.control.ListView;
import javafx.scene.control.PasswordField;
import javafx.scene.control.SplitPane;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextArea;
import javafx.scene.control.TextField;
import javafx.scene.input.MouseEvent;
import javafx.scene.layout.StackPane;

public abstract class BaseWikiAdmin {

	@FXML
	protected TableView<User> tableViewUser;

	@FXML
	protected TableColumn<User, String> columnUsername;

	@FXML
	protected TableColumn<User, String> columnUserFirstname;

	@FXML
	protected TableColumn<User, String> columnUserLastname;

	@FXML
	protected TableColumn<User, LocalDateTime> columnUserCreated;

	@FXML
	protected TableColumn<User, Boolean> columnUserActive;

	@FXML
	protected StackPane stackPane;

	@FXML
	protected SplitPane paneWiki;

	@FXML
	protected TextField textSearchCategory;

	@FXML
	protected ListView<Category> listViewCategory;

	@FXML
	protected TextField textSearchPages;

	@FXML
	protected TableView<Page> tableView;

	@FXML
	protected TableColumn<Page, Long> columnId;

	@FXML
	protected TableColumn<Page, String> columnTitle;

	@FXML
	protected TableColumn<Page, String> columnContent;

	@FXML
	protected TableColumn<Page, LocalDateTime> columnCreated;

	@FXML
	protected TableColumn<Page, LocalDateTime> columnUpdated;

	@FXML
	protected TableColumn<Page, Integer> columnStatus;

	@FXML
	protected TableColumn<Page, Integer> columnCategory;

	@FXML
	protected ComboBox<Category> comboCategory;

	@FXML
	protected Label labelPages;

	@FXML
	protected TextField textTitle;

	@FXML
	protected TextArea textContent;

	@FXML
	protected SplitPane paneUserManagement;

	@FXML
	protected TextField textUsername;

	@FXML
	protected TextField textFirstname;

	@FXML
	protected TextField textLastname;

	@FXML
	protected PasswordField textPassword;

	@FXML
	protected abstract void onButtonCreateAction(ActionEvent event);

	@FXML
	protected abstract void onButtonCreateNewUser(ActionEvent event);

	@FXML
	protected abstract void onButtonOpenUserManagementAction(ActionEvent event);

	@FXML
	protected abstract void onButtonOpenWikiAction(ActionEvent event);

	@FXML
	protected abstract void onButtonShowAllAction(ActionEvent event);

	@FXML
	protected abstract void onListViewCategoryClicked(MouseEvent event);

	@FXML
	protected abstract void onMenuItemDeleteCategory(ActionEvent event);

	@FXML
	protected abstract void onMenuItemEditCategory(ActionEvent event);

	@FXML
	protected abstract void onMenuItemNewCategory(ActionEvent event);
}
