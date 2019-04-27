COMPILER = gcc
CFLAGS   = -Wall -I include -g `sdl2-config --cflags` -c
LDFLAGS	= `sdl2-config --libs` -lSDL2_image -lSDL2_ttf -lSDL2_net -lm
CLIENT   = tank
SERVER   = tank-serv
OBJDIR   = obj
EXEDIR   = .

all: server client

framework.o: common/framework.c  
	$(COMPILER) $(CFLAGS) $< -o $(OBJDIR)/$@
	
client.o: client/client.c	
	$(COMPILER) $(CFLAGS) $< -o $(OBJDIR)/$@

server.o: server/server.c
	$(COMPILER) $(CFLAGS) $< -o $(OBJDIR)/$@

graphics.o: client/graphics.c
	$(COMPILER) $(CFLAGS) $< -o $(OBJDIR)/$@

network.o: common/network.c
	$(COMPILER) $(CFLAGS) $< -o $(OBJDIR)/$@

map.o: common/map.c
			$(COMPILER) $(CFLAGS) $< -o $(OBJDIR)/$@

animation.o: client/animation.c
	$(COMPILER) $(CFLAGS) $< -o $(OBJDIR)/$@

input.o: client/input.c
	$(COMPILER) $(CFLAGS) $< -o $(OBJDIR)/$@

tank.o: common/tank.c
			$(COMPILER) $(CFLAGS) $< -o $(OBJDIR)/$@

client: framework.o client.o graphics.o network.o map.o animation.o input.o tank.o
	$(CC) $(LDFLAGS) \
	$(OBJDIR)/framework.o \
	$(OBJDIR)/client.o \
	$(OBJDIR)/graphics.o \
	$(OBJDIR)/network.o \
	$(OBJDIR)/map.o \
	$(OBJDIR)/animation.o \
	$(OBJDIR)/input.o \
	$(OBJDIR)/tank.o \
	-o $(EXEDIR)/$(CLIENT)

server: server.o framework.o network.o tank.o map.o
	$(CC) $(LDFLAGS) \
	$(OBJDIR)/framework.o \
	$(OBJDIR)/network.o \
	$(OBJDIR)/server.o \
	$(OBJDIR)/tank.o \
	$(OBJDIR)/map.o \
	-o $(EXEDIR)/$(SERVER)

clean:
	rm $(OBJDIR)/*.o

