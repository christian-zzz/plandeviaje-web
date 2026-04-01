import React, { useState, useEffect, useRef, useCallback } from 'react';
import { CaretLeftIcon, CaretRightIcon, XIcon } from '@phosphor-icons/react';

const GAP = 24;

const getVisible = (width) => {
    if (width >= 1080) return 4;
    if (width >= 780) return 3;
    if (width >= 500) return 2;
    return 1;
};

/**
 * TestimonialCard — single testimonial with large image, stars, name, and quote.
 */
const TestimonialCard = ({ image, name, stars = 5, quote, onClick }) => (
    <div
        className="w-full h-full flex flex-col bg-white rounded-2xl shadow-lg overflow-hidden border border-white/70 group transition-shadow duration-200 hover:shadow-xl cursor-pointer"
        onClick={onClick}
    >
        {/* Image */}
        <div className="relative w-full overflow-hidden shrink-0">
            <img
                src={image}
                alt={name}
                className="w-full h-auto object-cover transition-transform duration-300 group-hover:scale-[1.04]"
            />
            {/* Gradient overlay at bottom of image */}
            <div className="absolute inset-x-0 bottom-0 h-24 bg-linear-to-t from-black/50 to-transparent" />
        </div>

        {/* Quote */}
        <div className="flex-1 px-4 py-4">
            <p className="text-sm text-gray-600 leading-relaxed italic">"{quote}"</p>
        </div>
    </div>
);

/**
 * TestimonialCarousel — infinite-loop carousel of testimonial cards.
 *
 * @param {string}  title
 * @param {string}  subtitle
 * @param {Array}   items — [{ image, name, stars, quote }]
 */
const TestimonialCarousel = ({ title, subtitle, items = [], className = '' }) => {
    const safeItems = items.filter(Boolean);
    const total = safeItems.length;

    // Lightbox state
    const [lightboxImg, setLightboxImg] = useState(null);

    useEffect(() => {
        if (!lightboxImg) return;
        const handleKey = (e) => { if (e.key === 'Escape') setLightboxImg(null); };
        document.addEventListener('keydown', handleKey);
        return () => document.removeEventListener('keydown', handleKey);
    }, [lightboxImg]);

    const containerRef = useRef(null);
    const [visible, setVisible] = useState(4);
    const [cardWidth, setCardWidth] = useState(0);

    useEffect(() => {
        const measure = () => {
            if (!containerRef.current) return;
            const w = containerRef.current.offsetWidth;
            const v = getVisible(w);
            const cw = Math.floor((w - GAP * (v - 1)) / v);
            setVisible(v);
            setCardWidth(cw);
        };
        measure();
        const ro = new ResizeObserver(measure);
        if (containerRef.current) ro.observe(containerRef.current);
        return () => ro.disconnect();
    }, []);

    const [index, setIndex] = useState(visible);
    const [animate, setAnimate] = useState(true);

    useEffect(() => {
        setAnimate(false);
        setIndex(visible);
    }, [visible]);

    useEffect(() => {
        if (!animate) {
            const id = requestAnimationFrame(() =>
                requestAnimationFrame(() => setAnimate(true))
            );
            return () => cancelAnimationFrame(id);
        }
    }, [animate]);

    const extended = [
        ...safeItems.slice(-visible),
        ...safeItems,
        ...safeItems.slice(0, visible),
    ];

    const go = useCallback((dir) => {
        setAnimate(true);
        setIndex((prev) => prev + dir);
    }, []);

    const handleTransitionEnd = useCallback(() => {
        if (index >= total + visible) {
            setAnimate(false);
            setIndex(visible);
        } else if (index < visible) {
            setAnimate(false);
            setIndex(total + visible - 1);
        }
    }, [index, total, visible]);

    if (total === 0) return null;

    const trackOffset = cardWidth > 0 ? -(index * (cardWidth + GAP)) : 0;

    return (
        <div className={`relative w-full px-10 sm:px-12 lg:px-16 ${className}`}>
            {(title || subtitle) && (
                <div className="mb-5 text-center">
                    {title && (
                        <h2 className="text-lg font-bold uppercase tracking-wide text-[#001f6c] sm:text-3xl">
                            {title}
                        </h2>
                    )}
                    {subtitle && (
                        <p className="mt-1 text-sm text-[#6c7eab] sm:text-lg">
                            {subtitle}
                        </p>
                    )}
                </div>
            )}

            {/* Prev arrow */}
            <button
                type="button"
                onClick={() => go(-1)}
                aria-label="Previous testimonials"
                className="absolute left-1 sm:left-2 top-1/2 z-10 -translate-y-1/2 rounded-full bg-white/90 hover:bg-white hover:scale-110 active:scale-95 p-2 shadow-md transition-all duration-200"
            >
                <CaretLeftIcon className="h-5 w-5 text-[#001f6c]" />
            </button>

            {/* Viewport */}
            <div ref={containerRef} className="overflow-hidden">
                <div
                    className={`flex items-stretch ${animate ? 'transition-transform duration-500 ease-in-out' : ''}`}
                    style={{ gap: `${GAP}px`, transform: `translateX(${trackOffset}px)` }}
                    onTransitionEnd={handleTransitionEnd}
                >
                    {extended.map((item, i) => (
                        <div
                            key={i}
                            className="shrink-0"
                            style={{ width: cardWidth > 0 ? `${cardWidth}px` : `calc(${100 / visible}% - ${GAP * (visible - 1) / visible}px)` }}
                        >
                            <TestimonialCard {...item} onClick={() => setLightboxImg(item.image)} />
                        </div>
                    ))}
                </div>
            </div>

            {/* Next arrow */}
            <button
                type="button"
                onClick={() => go(1)}
                aria-label="Next testimonials"
                className="absolute right-1 sm:right-2 top-1/2 z-10 -translate-y-1/2 rounded-full bg-white/90 hover:bg-white hover:scale-110 active:scale-95 p-2 shadow-md transition-all duration-200"
            >
                <CaretRightIcon className="h-5 w-5 text-[#001f6c]" />
            </button>

            {/* ── Lightbox ──────────────────────────────────────── */}
            {lightboxImg && (
                <div
                    className="fixed inset-0 z-50 flex items-center justify-center bg-black/80 backdrop-blur-sm animate-in fade-in"
                    onClick={() => setLightboxImg(null)}
                >
                    <button
                        type="button"
                        onClick={() => setLightboxImg(null)}
                        className="absolute top-4 right-4 z-10 rounded-full bg-white/20 hover:bg-white/40 p-2 transition-colors"
                        aria-label="Close"
                    >
                        <XIcon className="w-6 h-6 text-white" />
                    </button>
                    <img
                        src={lightboxImg}
                        alt="Testimonial"
                        className="max-h-[90vh] max-w-[90vw] rounded-2xl shadow-2xl object-contain"
                        onClick={(e) => e.stopPropagation()}
                    />
                </div>
            )}
        </div>
    );
};

export default TestimonialCarousel;
