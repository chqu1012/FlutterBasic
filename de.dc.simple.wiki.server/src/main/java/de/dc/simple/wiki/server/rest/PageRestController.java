package de.dc.simple.wiki.server.rest;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.data.rest.webmvc.ResourceNotFoundException;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RestController;

import de.dc.simple.wiki.server.control.WikiAdmin;
import de.dc.simple.wiki.server.model.Page;
import de.dc.simple.wiki.server.repository.PageRepository;

@RestController
public class PageRestController {

	@Autowired PageRepository pageRepository;
	@Autowired WikiAdmin wikiAdmin;

	@GetMapping("/pages")
	public List<Page> getAllAccounts() {
		return pageRepository.findAll();
	}

	@GetMapping("/pages/{id}")
	public Page getAccountById(@PathVariable(value = "id") Long pageId) {
		return pageRepository.findById(pageId).orElseThrow(() -> new ResourceNotFoundException("PageId: " + pageId));
	}

	@PostMapping("/newpage")
	Page newEmployee(@RequestBody Page newPage) {
		newPage.setUpdated(LocalDateTime.now());
		newPage.setCreated(LocalDateTime.now());
		
		wikiAdmin.add(newPage);
		
		return pageRepository.save(newPage);
	}
}
