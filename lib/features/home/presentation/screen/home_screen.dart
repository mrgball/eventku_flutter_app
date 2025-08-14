import 'package:carousel_slider/carousel_slider.dart';
import 'package:event_app/core/config/constant.dart';
import 'package:event_app/core/config/extension.dart';
import 'package:event_app/features/auth/presentation/bloc/auth_bloc.dart';
import 'package:event_app/features/event/domain/entity/event.dart';
import 'package:event_app/features/home/presentation/bloc/home_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final AuthBloc _authBloc = context.read<AuthBloc>();
  final ValueNotifier<int> _currentBannerPage = ValueNotifier<int>(0);

  @override
  void initState() {
    super.initState();

    context.read<HomeBloc>().add(
      FetchHomeEndpointEvent(user: _authBloc.state.user),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Icon(Icons.abc_sharp),
            label: 'ABC Sharp',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.zoom_out_rounded),
            label: 'Zoom Out',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.settings), label: 'Profile'),
        ],
        currentIndex: 0, // indeks yang sedang aktif
        selectedItemColor: Colors.blue,
        unselectedItemColor: Colors.grey,
        onTap: (index) {
          // fungsi saat icon ditekan, misal update state
        },
      ),

      body: SafeArea(
        child: BlocSelector<HomeBloc, HomeState, HomeState>(
          selector: (state) => state,
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(height: 16),
                    _buildAppBar(),
                    const SizedBox(height: 32),
                    _buildCarouselSlider(state),
                    const SizedBox(height: 24),
                    ..._buildPopularEvents(state.listPopularEvent),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  List<Widget> _buildPopularEvents(List<Event> listEvent) {
    return [
      Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Popular Events',
            style: context.text.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            'See more',
            style: context.text.bodySmall?.copyWith(
              color: context.disableColor,
            ),
          ),
        ],
      ),
      SizedBox(height: 16),
      GridView.builder(
        padding: EdgeInsets.zero,
        shrinkWrap: true,
        itemCount: listEvent.take(6).length,
        physics: NeverScrollableScrollPhysics(),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 16,
          mainAxisSpacing: 16,
          childAspectRatio: 0.65,
        ),
        itemBuilder: (context, index) => _buildEventItem(listEvent[index]),
      ),
      SizedBox(height: 16),
    ];
  }

  Widget _buildEventItem(Event event) {
    return GestureDetector(
      onTap:
          () => Navigator.of(
            context,
          ).pushNamed(Constant.routeEventDetail, arguments: {'event': event}),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            decoration: BoxDecoration(
              color: Colors.white,
              border: Border.all(
                color: Colors.grey.shade200,
                width: 1.5,
                style: BorderStyle.solid,
              ),
              borderRadius: BorderRadius.circular(4),
              boxShadow: [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 6,
                  offset: const Offset(0, 8),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(4),
                bottom: Radius.circular(4),
              ),
              child: Image.network(
                event.banner,
                height: context.dh * 0.24,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
          ),
          const SizedBox(height: 8),
          SizedBox(
            child: Text(
              event.name,
              style: context.text.bodyMedium?.copyWith(
                fontWeight: FontWeight.bold,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  Widget _buildAppBar() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hello,',
              style: context.text.bodyMedium?.copyWith(
                color: context.hintColor,
              ),
            ),
            Text(
              _authBloc.state.user?.fullname.toUpperCase() ?? '',
              style: context.text.titleLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),

        Image.network(
          'https://avatar.iran.liara.run/public/girl',
          width: 50,
          height: 50,
          fit: BoxFit.cover,
          alignment: Alignment.center,
          errorBuilder: (context, error, stackTrace) {
            return Container(
              width: 50,
              height: 50,
              color: Colors.grey[200],
              child: const Icon(Icons.person, color: Colors.grey),
            );
          },
        ),
      ],
    );
  }

  Widget _buildCarouselSlider(HomeState state) {
    return Column(
      children: [
        CarouselSlider(
          items:
              state.listBanner.map((banner) {
                return Builder(
                  builder: (BuildContext context) {
                    return ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Stack(
                        fit: StackFit.expand,
                        children: [
                          Image.network(
                            banner.imageUrl,
                            fit: BoxFit.cover,
                            loadingBuilder: (context, child, loadingProgress) {
                              if (loadingProgress == null) return child;
                              return Container(
                                color: Colors.grey.shade200,
                                child: const Center(
                                  child: CircularProgressIndicator(
                                    strokeWidth: 2,
                                  ),
                                ),
                              );
                            },
                            errorBuilder: (context, error, stackTrace) {
                              return Container(
                                color: Colors.grey.shade200,
                                child: const Center(
                                  child: Icon(
                                    Icons.broken_image,
                                    size: 40,
                                    color: Colors.grey,
                                  ),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    );
                  },
                );
              }).toList(),
          options: CarouselOptions(
            height: 180,
            viewportFraction: 0.9,
            initialPage: 0,
            enableInfiniteScroll: true,
            autoPlay: true,
            autoPlayInterval: const Duration(seconds: 30),
            autoPlayAnimationDuration: const Duration(milliseconds: 800),
            autoPlayCurve: Curves.fastOutSlowIn,
            enlargeCenterPage: true,
            enlargeFactor: 0.15,
            scrollDirection: Axis.horizontal,
            onPageChanged: (index, reason) {
              _currentBannerPage.value = index;
            },
          ),
        ),
        const SizedBox(height: 12),
        ValueListenableBuilder<int>(
          valueListenable: _currentBannerPage,
          builder: (context, value, _) {
            return Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                state.listBanner.length,
                (index) => Container(
                  width: 6,
                  height: 6,
                  margin: const EdgeInsets.symmetric(horizontal: 4),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color:
                        value == index
                            ? context.primaryColor
                            : Colors.grey.shade300,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}
