Test.love :
	zip -9 -r Test.love .

push : Test.love
	scp Test.love cpi@192.168.1.48:~/games/Love2D/

clean :
	rm Test.love
