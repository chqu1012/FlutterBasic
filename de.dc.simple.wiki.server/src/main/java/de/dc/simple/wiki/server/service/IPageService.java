package de.dc.simple.wiki.server.service;

import java.util.List;

import de.dc.simple.wiki.server.model.Page;

public interface IPageService {

	Page create(String title, String content);
	
	List<Page> findAll();
}
