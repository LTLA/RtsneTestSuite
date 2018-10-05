all: bhtsne/.cloned bhtsne/.modified bhtsne/bh_tsne

bhtsne/.cloned:
	git clone https://github.com/lvdmaaten/bhtsne && touch bhtsne/.cloned	

bhtsne/.modified: bhtsne/.cloned
	cd bhtsne; git checkout -- tsne.cpp
	cat bhtsne/tsne.cpp \
		| sed 's@^.*randn() \*.*@FILE* h=fopen("$(CURDIR)/testthat/init.dat", "r+b"); if (h==NULL) { printf("init file not available\\\\n"); } fread(Y, sizeof(double), N*no_dims, h); fclose(h);@' \
		| sed 's@.*) tree->computeNonEdgeForces.*neg_f.*@for(int n = 0; n < N; n++) { double tmp=0; tree->computeNonEdgeForces(n, theta, neg_f + n * D, \&tmp); sum_Q += tmp; }@' \
		| sed 's@.*) tree->computeNonEdgeForces.*buff.*@for(int n = 0; n < N; n++) { double tmp=0; tree->computeNonEdgeForces(n, theta, buff, \&tmp); sum_Q += tmp; }@' \
		> tmp.cpp
	mv tmp.cpp bhtsne/tsne.cpp 
	cd bhtsne; git checkout -- sptree.cpp
	cat bhtsne/sptree.cpp \
		| sed 's@^.*children\[i\]->computeNonEdgeForces.*@for(unsigned int i = 0; i < no_children; i++) { double tmp=0; children[i]->computeNonEdgeForces(point_index, theta, neg_f, \&tmp); *sum_Q += tmp; }@' > tmp.cpp
	mv tmp.cpp bhtsne/sptree.cpp 
	touch bhtsne/.modified

bhtsne/bh_tsne: bhtsne/.modified
	cd bhtsne && g++ sptree.cpp tsne.cpp tsne_main.cpp -o bh_tsne -O2

clean:
	rm -rf bhtsne 
