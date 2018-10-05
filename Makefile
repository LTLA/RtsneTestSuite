all: .cloned .modified bhtsne/bhtsne

.cloned:
	git clone https://github.com/lvdmaaten/bhtsne && touch .cloned

.modified: .cloned
	cat bhtsne/tsne.cpp | sed "s/^double TSNE::randn() {/double TSNE::randn() { return 0;/" > tmp.cpp
	mv tmp.cpp bhtsne/tsne.cpp && touch .modified

bhtsne/bhtsne: .modified
	cd bhtsne && g++ sptree.cpp tsne.cpp tsne_main.cpp -o bhtsne -O2

clean:
	rm -rf bhtsne .cloned .modified
