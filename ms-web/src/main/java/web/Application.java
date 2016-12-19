package web;

import org.springframework.boot.SpringApplication;
import org.springframework.boot.autoconfigure.SpringBootApplication;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

/**
 * Created by sjzc66 on 2016年11月17日
 */
@SpringBootApplication
@RestController
//@EnableAutoConfiguration
public class Application {

    @RequestMapping("/")
    public String greeting(){
        return "Hello World!";
    }

    public static void main(String[] args) {
        SpringApplication.run(Application.class,args);
    }
}
