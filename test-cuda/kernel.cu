#include <thrust/device_vector.h>
#include <thrust/swap.h>
#include <thrust/host_vector.h>
#include <thrust/sequence.h>

#include <numeric>

void permutations(thrust::device_vector<char> ch, int l, int r) {
	if (l == r) {
		thrust::copy(ch.begin(), ch.end(), std::ostream_iterator<char>(std::cout));
		std::cout << std::endl;
	}

	for (int i = l; i < r; i++) {
		thrust::swap(*(ch.begin() + l), *(ch.begin() + i));
		permutations(ch, l + 1, r);
		thrust::swap(*(ch.begin() + l), *(ch.begin() + i));
	}
}

int main()
{
	thrust::device_vector<char> s_d(26);
	thrust::sequence(s_d.begin(), s_d.end(), 'a');

	permutations(s_d, 0, s_d.size() - 1);

	return 0;
}
