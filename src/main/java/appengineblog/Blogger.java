package appengineblog;

import com.googlecode.objectify.Key;
import com.googlecode.objectify.annotation.Entity;
import com.googlecode.objectify.annotation.Id;

@Entity
public class Blogger {
    @Id long id;
    String name;

    public Blogger(String name) {
        this.name = name;
    }
}
