package de.dc.simple.wiki.server;
import java.time.LocalDateTime;

import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.CommandLineRunner;
import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.context.annotation.ComponentScan;

import de.dc.simple.wiki.server.model.Page;
import de.dc.simple.wiki.server.repository.PageRepository;

@SpringBootApplication
@ComponentScan
public class SimpleWikiApplication implements CommandLineRunner{

	private static final Logger log = LoggerFactory.getLogger(SimpleWikiApplication.class);
	
	@Autowired PageRepository pageRepository;
	
    public static void main(String[] args) {
    	log.info("Launch Simple Wiki Application");
    	SpringApplication.run(SimpleWikiApplication.class, args);
    }

	@Override
	public void run(String... args) throws Exception {
//		for (int i = 0; i < 10; i++) {
//			Page page = new Page();
//			page.setTitle("Spring Boot Application "+LocalDateTime.now());
//			page.setContent("Dummy Content");
//			page.setCreated(LocalDateTime.now());
//			page.setUpdated(LocalDateTime.now());
//			pageRepository.save(page);
//		}
	}
}
