package com.mavisgs.data;

import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.RestController;

@RestController
public class HealthController {

	@GetMapping("/_healthcheck")
	public String get() {
		return "ok";
	}
}
