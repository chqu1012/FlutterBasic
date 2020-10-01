package de.dc.simple.wiki.server.control;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;

import de.dc.simple.wiki.server.model.Page;
import de.dc.simple.wiki.server.service.IPageService;
import javafx.beans.binding.Bindings;
import javafx.beans.value.ChangeListener;
import javafx.beans.value.ObservableValue;
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
		columnStatus.setCellValueFactory(new PropertyValueFactory<>("formatStatus"));
		
		tableView.setItems(filteredData);
		tableView.setFixedCellSize(20.0);
		
		masterData.addAll(pageService.findAll());
		
		labelPages.textProperty().bind(Bindings.size(masterData).asString());
		
		textSearchPages.textProperty().addListener(new ChangeListener<String>() {
			@Override
			public void changed(ObservableValue<? extends String> observable, String oldValue, String newValue) {
				if(newValue!=null) {
					filteredData.setPredicate(e->{
						boolean containsContent = e.getContent().toLowerCase().contains(newValue.toLowerCase());
						boolean containsTitle = e.getTitle().toLowerCase().contains(newValue.toLowerCase());
						boolean containsStatus = e.getFormatStatus().toLowerCase().contains(newValue.toLowerCase());
						boolean containsCreated = e.getCreated().toString().contains(newValue.toLowerCase());
						boolean containsUpdated = e.getUpdated().toString().contains(newValue.toLowerCase());
						return containsUpdated || containsCreated || containsContent || containsTitle || containsStatus;
					});
				}
			}
		});
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
