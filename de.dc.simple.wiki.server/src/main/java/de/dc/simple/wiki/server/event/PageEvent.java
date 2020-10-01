package de.dc.simple.wiki.server.event;

import org.springframework.context.ApplicationEvent;

import de.dc.simple.wiki.server.model.Page;

public class PageEvent extends ApplicationEvent {

	private static final long serialVersionUID = 1L;

	private Page page;

	public PageEvent(Object source, Page page) {
		super(source);
		this.setPage(page);
	}

	public Page getPage() {
		return page;
	}

	public void setPage(Page page) {
		this.page = page;
	}

}
