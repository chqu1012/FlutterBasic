package de.dc.simple.wiki.server.model;

import java.time.LocalDateTime;

import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.GenerationType;
import javax.persistence.Id;
import javax.persistence.Lob;

@Entity
public class Page {

	@Id
	@GeneratedValue(strategy = GenerationType.AUTO)
	private long id;
	
	@Lob 
	private String title;
	
	@Lob 
	private String content;
	private LocalDateTime created;
	private LocalDateTime updated;
	private int status;

	public Page() {
	}
	
	public long getId() {
		return id;
	}

	public void setId(long id) {
		this.id = id;
	}

	public String getTitle() {
		return title;
	}

	public void setTitle(String title) {
		this.title = title;
	}

	public String getContent() {
		return content;
	}

	public void setContent(String content) {
		this.content = content;
	}

	public LocalDateTime getCreated() {
		return created;
	}

	public void setCreated(LocalDateTime created) {
		this.created = created;
	}

	public LocalDateTime getUpdated() {
		return updated;
	}

	public void setUpdated(LocalDateTime updated) {
		this.updated = updated;
	}

	public int getStatus() {
		return status;
	}

	public void setStatus(int status) {
		this.status = status;
	}
	
	public String getFormatStatus() {
		switch (status) {
		case 0:
			return "Available";
		case -1:
			return "Deleted";
		default:
			return "N/A";
		}
	}

}
