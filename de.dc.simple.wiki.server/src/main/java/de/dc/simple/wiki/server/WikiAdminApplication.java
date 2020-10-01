package de.dc.simple.wiki.server;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.boot.web.client.RestTemplateBuilder;
import org.springframework.context.ConfigurableApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.web.client.RestTemplate;

import javafx.application.Application;
import javafx.application.HostServices;
import javafx.fxml.FXMLLoader;
import javafx.scene.Parent;
import javafx.scene.Scene;
import javafx.scene.paint.Color;
import javafx.stage.Stage;
import javafx.stage.StageStyle;

@SpringBootApplication
public class WikiAdminApplication extends Application {

    private ConfigurableApplicationContext springContext;
    private Parent root;
	private FXMLLoader fxmlLoader;
	
	@Bean
	public RestTemplate restTemplate(RestTemplateBuilder builder) {
		return builder.build();
	}

    @Override
    public void init() throws Exception {
        springContext = SpringApplication.run(WikiAdminApplication.class);
        fxmlLoader = new FXMLLoader(getClass().getResource("WikiAdmin.fxml"));
        fxmlLoader.setControllerFactory(springContext::getBean);
        root = fxmlLoader.load();
    }

    @Override
    public void start(Stage primaryStage) throws Exception {
        primaryStage.setTitle("Wiki Application");
        Scene scene = new Scene(root, 1400, 820);
        scene.setFill(Color.TRANSPARENT);
        primaryStage.initStyle(StageStyle.DECORATED);
        primaryStage.setScene(scene);
        primaryStage.show();
    }

    @Override
    public void stop() throws Exception {
        springContext.stop();
    }

    @Bean
    public HostServices getHostService() {
    	return getHostServices();
    }
    

    public static void main(String[] args) {
        launch(WikiAdminApplication.class);
    }
}