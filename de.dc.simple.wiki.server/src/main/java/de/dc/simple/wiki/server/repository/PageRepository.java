package de.dc.simple.wiki.server.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import de.dc.simple.wiki.server.model.Page;

public interface PageRepository extends JpaRepository<Page, Long>{

}
