package de.dc.simple.wiki.server.control;
import java.time.LocalDateTime;

import de.dc.simple.wiki.server.model.Page;
import javafx.event.ActionEvent;
import javafx.fxml.FXML;
import javafx.scene.control.Label;
import javafx.scene.control.SplitPane;
import javafx.scene.control.TableColumn;
import javafx.scene.control.TableView;
import javafx.scene.control.TextArea;
import javafx.scene.control.TextField;

public abstract class BaseWikiAdmin {

	@FXML
	protected TextField textSearchPages;
	
    @FXML
    protected SplitPane root;

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
    protected Label labelPages;

    @FXML
    protected TextField textTitle;

    @FXML
    protected TextArea textContent;

    @FXML
    protected abstract void onButtonCreateAction(ActionEvent event);
}
