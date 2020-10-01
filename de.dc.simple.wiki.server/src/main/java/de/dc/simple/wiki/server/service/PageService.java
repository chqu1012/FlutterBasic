package de.dc.simple.wiki.server.service;

import java.time.LocalDateTime;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import de.dc.simple.wiki.server.model.Page;
import de.dc.simple.wiki.server.repository.PageRepository;

@Service
public class PageService implements IPageService{

	@Autowired PageRepository pageRepository;
	
	@Override
	public Page create(String title, String content, Long categoryId) {
		Page page = new Page();
		page.setContent(content);
		page.setTitle(title);
		page.setCreated(LocalDateTime.now());
		page.setUpdated(LocalDateTime.now());
		page.setCategoryId(categoryId);
		return pageRepository.save(page);
	}

	@Override
	public List<Page> findAll() {
		return pageRepository.findAll();
	}

}
