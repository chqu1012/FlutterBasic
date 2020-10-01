package de.dc.simple.wiki.server.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import de.dc.simple.wiki.server.model.Category;

public interface CategoryRepository extends JpaRepository<Category, Long> {

}
