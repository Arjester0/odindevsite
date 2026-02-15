package main 

import "core:fmt" 
import "core:os" 
import "core:strings" 
// bindings for CMark
import cm "vendor:commonmark" 

// TODO: 
// 1. Make it read dirs 
// 2. Make every markdown file have a template wrapped in it 
// 3. Vibe code the css based off otaku website 
// 4. clean it up 
// 5. host on github pages or cloudflare pages 

main :: proc() 
{
    file, ok := os.read_entire_file("test.md", context.allocator); 
    if(!ok) 
    {
	fmt.println("Error reading file"); 
	return 
    } 

    markdown := strings.clone_to_cstring(string(file)); 
    html := cm.markdown_to_html(markdown, len(markdown), {.Safe}); 

    os.write_entire_file("output.html", transmute([]u8)string(html)); 

    defer delete(file, context.allocator); 
} 
