import 'package:daryo/core/extensions/text_extensions.dart';
import 'package:daryo/presentation/support/extensions/color_extension.dart';
import 'package:flutter/material.dart';

import '../../../core/gen/assets/assets.gen.dart';

class SocialPost {
  final String userName;
  final String userImage;
  final String timeAgo;
  final String content;
  final int likes;
  final int replies;
  final bool isLiked;

  SocialPost({
    required this.userName,
    required this.userImage,
    required this.timeAgo,
    required this.content,
    required this.likes,
    required this.replies,
    this.isLiked = false,
  });
}

class SocialPostWidget extends StatefulWidget {
  const SocialPostWidget({super.key});

  @override
  State<SocialPostWidget> createState() => _SocialPostWidgetState();
}

class _SocialPostWidgetState extends State<SocialPostWidget> {
  final List<SocialPost> posts = [
    SocialPost(
      userName: 'Alex Mora Moa',
      userImage: 'https://i.pravatar.cc/150?img=12',
      timeAgo: '24 min ago',
      content: 'Ko\'tarilish yaqinda, bozor hozir haddan tashqari xarid darajasida',
      likes: 33,
      replies: 0,
      isLiked: true,
    ),
    SocialPost(
      userName: 'Alex Mora Moa',
      userImage: 'https://i.pravatar.cc/150?img=33',
      timeAgo: '30 min ago',
      content:
          'Asabiylashib, jadvalimni tartibga solishga harakat qilyapman, shuning uchun AQSh ochilganda bir soat yoki undan ko\'proq vaqt ekranga tikilib qolaman',
      likes: 8,
      replies: 0,
      isLiked: false,
    ),
  ];

  void _toggleLike(int index) {
    setState(() {
      posts[index] = SocialPost(
        userName: posts[index].userName,
        userImage: posts[index].userImage,
        timeAgo: posts[index].timeAgo,
        content: posts[index].content,
        likes: posts[index].isLiked ? posts[index].likes - 1 : posts[index].likes + 1,
        replies: posts[index].replies,
        isLiked: !posts[index].isLiked,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(vertical: 8),
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return _PostCard(
            post: posts[index],
            onLikePressed: () => _toggleLike(index),
          );
        },
      ),
    );
  }
}

class _PostCard extends StatelessWidget {
  final SocialPost post;
  final VoidCallback onLikePressed;

  const _PostCard({
    required this.post,
    required this.onLikePressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                      image: Assets.imagesDaryo.pngImages.commentAvatar.provider(),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 7,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [post.userName.s(14).w(700).c(context.textPrimary), post.timeAgo.s(12).w(500).c(context.textSecondary)],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          // Content
          Row(
            children: [
              Expanded(
                flex: 1,
                child: SizedBox.shrink(),
              ),
              const SizedBox(width: 12),
              Expanded(
                flex: 7,
                child: Column(
                  children: [
                    post.content.s(12).w(400).c(context.textPrimary).h(1.6),
                    const SizedBox(height: 16),
                    // Actions
                    Row(
                      children: [
                        _ActionButton(
                          icon: post.isLiked ? Assets.imagesDaryo.icCommentHeartRed.svg() : Assets.imagesDaryo.icCommentHeart.svg(),
                          label: '${post.likes} Likes',
                          color: post.isLiked ? Colors.red : null,
                          onPressed: onLikePressed,
                        ),
                        const SizedBox(width: 24),
                        _ActionButton(
                          icon: Assets.imagesDaryo.icCommentMessageCircle.svg(),
                          label: '${post.replies} Replies',
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ],
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}

class _ActionButton extends StatefulWidget {
  final Widget icon;
  final String label;
  final Color? color;
  final VoidCallback onPressed;

  const _ActionButton({
    required this.icon,
    required this.label,
    this.color,
    required this.onPressed,
  });

  @override
  State<_ActionButton> createState() => _ActionButtonState();
}

class _ActionButtonState extends State<_ActionButton> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(begin: 1.0, end: 0.9).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTap() {
    _controller.forward().then((_) {
      _controller.reverse();
    });
    widget.onPressed();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: _handleTap,
      child: ScaleTransition(
        scale: _scaleAnimation,
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          decoration: BoxDecoration(
            color: context.containerBackground,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              widget.icon,
              const SizedBox(width: 4),
              widget.label.s(12).w(500).c(context.textSecondary)
            ],
          ),
        ),
      ),
    );
  }
}
