package de.dc.simple.wiki.server.rest;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.context.ApplicationEventPublisher;
import org.springframework.data.rest.webmvc.ResourceNotFoundException;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import de.dc.simple.wiki.server.event.PageEvent;
import de.dc.simple.wiki.server.model.Page;
import de.dc.simple.wiki.server.repository.PageRepository;

@RestController
public class PageRestController {

	@Autowired ApplicationEventPublisher applicationEventPublisher;
	@Autowired PageRepository pageRepository;
	
	@GetMapping("/pages")
	public List<Page> findAll() {
		return pageRepository.findAll();
	}

	@GetMapping("/pages/{id}")
	public Page getById(@PathVariable(value = "id") Long pageId) {
		return pageRepository.findById(pageId).orElseThrow(() -> new ResourceNotFoundException("PageId: " + pageId));
	}

	@PostMapping("/newpage")
	Page newPage(@RequestBody Page newPage) {
		newPage.setUpdated(LocalDateTime.now());
		newPage.setCreated(LocalDateTime.now());
		
		applicationEventPublisher.publishEvent(new PageEvent(this, newPage));
		
		return pageRepository.save(newPage);
	}
}
