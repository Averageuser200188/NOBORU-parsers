MangaHubRU=Parser:new("MangaHub (Русский)","https://mangahub.ru","RUS","MANGAHUBRU",2)local function a(b)if u8c then return b:gsub("&#([^;]-);",function(c)local d=tonumber("0"..c)or tonumber(c)return d and u8c(d)or"&#"..c..";"end):gsub("&([^;]-);",function(c)return HTML_entities and HTML_entities[c]and u8c(HTML_entities[c])or"&"..c..";"end)else return b end end;local function e(f)local g={}Threads.insertTask(g,{Type="StringRequest",Link=f,Table=g,Index="string",Header1="Referer: "..MangaHubRU.Link})while Threads.check(g)do coroutine.yield(false)end;return g.string or""end;function MangaHubRU:getManga(f,h)local i=e(f)h.NoPages=true;for j,k,l in i:gmatch('<a href="/([^"]-)" class="d%-block rounded fast%-view%-layer"[^>]*>.-data%-background%-image="([^"]-)"></div>.-<a class="fw%-medium[^>]->%s*(.-)%s*</a>')do h[#h+1]=CreateManga(a(l),j,self.Link..k:gsub("%%","%%%%"),self.ID,self.Link.."/"..j)h.NoPages=false;coroutine.yield(false)end end;function MangaHubRU:getPopularManga(m,h)self:getManga(self.Link.."/explore?filter%5Bsort%5D=rating&filter%5Btypes%5D%5Bexcludes%5D=&filter%5Bgenres%5D%5Bexcludes%5D=&filter%5Bstatus%5D%5Bexcludes%5D=&filter%5Bcountry%5D%5Bexcludes%5D=&page="..m,h)end;function MangaHubRU:getLatestManga(m,h)self:getManga(self.Link.."/explore?filter%5Bsort%5D=update&filter%5Btypes%5D%5Bexcludes%5D=&filter%5Bgenres%5D%5Bexcludes%5D=&filter%5Bstatus%5D%5Bexcludes%5D=&filter%5Bcountry%5D%5Bexcludes%5D=&page="..m,h)end;function MangaHubRU:searchManga(n,m,h)self:getManga(self.Link.."/search/manga?filter%5Bsort%5D=score&query="..n.."&filter%5Bquery%5D="..n.."&filter%5Btypes%5D%5Bexcludes%5D=&filter%5Bgenres%5D%5Bexcludes%5D=&filter%5Bstatus%5D%5Bexcludes%5D=&filter%5Bcountry%5D%5Bexcludes%5D=&page="..m,h)end;function MangaHubRU:getChapters(o,h)local i=e(self.Link.."/"..o.Link:gsub("title/","chapters/"))or""local p={}for j,l in i:gmatch('href="/read/([^"]-)">%s*<span class="text%-truncate">%s*([^<]*)%s*</span>')do p[#p+1]={Name=a(l:gsub("[\t\n ]+"," ")),Link=j,Pages={},Manga=o}end;for q=#p,1,-1 do h[#h+1]=p[q]end end;function MangaHubRU:prepareChapter(r,h)local i=e(self.Link.."/read/"..r.Link)for j in i:gmatch("src&quot;:&quot;[\\/]*([^&]-)&quot;")do h[#h+1]={Link="https://"..j:gsub("\\/","/"):gsub("%%","%%%%"),Header1="Referer:"..self.Link}end end;function MangaHubRU:loadChapterPage(f,h)h.Link=f end