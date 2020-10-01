package de.dc.simple.wiki.server.control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import de.dc.simple.wiki.server.model.Page;
import de.dc.simple.wiki.server.service.IPageService;
import javafx.beans.binding.Bindings;
import javafx.collections.FXCollections;
import javafx.collections.ObservableList;
import javafx.collections.transformation.FilteredList;
import javafx.event.ActionEvent;
import javafx.scene.control.cell.PropertyValueFactory;

@Controller
public class WikiAdmin extends BaseWikiAdmin{

	@Autowired IPageService pageService;
	
	ObservableList<Page> masterData = FXCollections.observableArrayList();
	FilteredList<Page> filteredData = new FilteredList<>(masterData);

	public void initialize() {
		columnContent.setCellValueFactory(new PropertyValueFactory<>("content"));
		columnTitle.setCellValueFactory(new PropertyValueFactory<>("title"));
		columnId.setCellValueFactory(new PropertyValueFactory<>("id"));
		columnCreated.setCellValueFactory(new PropertyValueFactory<>("created"));
		columnUpdated.setCellValueFactory(new PropertyValueFactory<>("updated"));
		tableView.setItems(filteredData);
		
		masterData.addAll(pageService.findAll());
		
		labelPages.textProperty().bind(Bindings.size(masterData).asString());
	}
	
	@Override
	protected void onButtonCreateAction(ActionEvent event) {
		String title = textTitle.getText();
		String content = textContent.getText();
		
		Page newPage = pageService.create(title, content);
		masterData.add(newPage);
		
		textTitle.setText("");
		textContent.setText("");
	}
}
