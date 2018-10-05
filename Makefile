all: .cloned .modified bhtsne/bhtsne

.cloned:
	git clone https://github.com/lvdmaaten/bhtsne && touch .cloned	

.modified: .cloned
	cd bhtsne; git checkout -- tsne.cpp
	cat bhtsne/tsne.cpp | sed 's@^.*randn() \*.*@FILE* h=fopen("$(CURDIR)/testthat/init.dat", "r+b"); if (h==NULL) { printf("init file not available\\\\n"); } fread(Y, sizeof(double), N*no_dims, h); fclose(h);@' > tmp.cpp
	mv tmp.cpp bhtsne/tsne.cpp && touch .modified

bhtsne/bhtsne: .modified
	cd bhtsne && g++ sptree.cpp tsne.cpp tsne_main.cpp -o bhtsne -O2

clean:
	rm -rf bhtsne .cloned .modified
