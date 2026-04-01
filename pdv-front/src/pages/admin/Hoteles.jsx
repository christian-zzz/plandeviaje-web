import React, { useState, useEffect } from 'react';
import useDocumentTitle from '../../hooks/useDocumentTitle';
import api from '../../api/axios';
import { showSuccess, showError, showConfirm, showInfo } from '../../utils/swal';
import AdminTable from '../../components/dashboard/AdminTable';
import FormCard, {
    FormInput,
    FormSelect,
    FormSelectCreatable,
    FormMultiSelect,
    FormFeatureList,
    FormPlaceSearch,
    FormTextarea,
    FormCheckbox,
    FormImageUpload,
    FormGalleryUpload,
} from '../../components/dashboard/FormCard';
import { getImageUrl } from '../../utils/imageHandler';
import { CheckIcon, PencilSimpleIcon, ArrowLeftIcon, ArrowRightIcon, ForkKnifeIcon, BedIcon, SparkleIcon, StarIcon, CheckCircleIcon, XCircleIcon, HouseIcon, ImageIcon, ArticleIcon } from '@phosphor-icons/react';

// ── Board-type Spanish label map (DB stores English keys) ────────────────────
const BOARD_TYPE_ES = {
    'All Inclusive': 'Todo Incluido',
    'Breakfast Only': 'Solo Desayuno',
    'Half Board': 'Media Pensión',
    'Full Board': 'Pensión Completa',
    'Room Only': 'Solo Habitación',
    'No Meals': 'Sin Comidas',
};
const boardLabel = (type) => BOARD_TYPE_ES[type] ?? type;

// ── Thumbnail cell ────────────────────────────────────────────────────────────
const Thumb = ({ image }) => (
    <div className="w-16 h-16 rounded-xl overflow-hidden shadow-sm shrink-0 mx-auto"
        style={{ background: 'linear-gradient(135deg, #001f6c, #001f6ccc)' }}>
        {image
            ? <img src={getImageUrl(image)} alt="" className="w-full h-full object-cover" />
            : <div className="w-full h-full flex items-center justify-center text-white text-xs font-bold">HT</div>}
    </div>
);

// ── Regime cell ───────────────────────────────────────────────────────────────
const RegimeCell = ({ row }) => {
    const rawBoard = typeof row.board_type === 'object' ? row.board_type?.type : row.board_type;
    const regime = boardLabel(rawBoard) || row.boardType?.type || row.boardType?.name || '—';
    return (
        <span className="inline-flex items-center gap-1 text-[11px] font-semibold text-[#001f6c] bg-[#f4f7fb] px-2.5 py-1 rounded-full border border-[#001f6c]/10 whitespace-nowrap">
            <ForkKnifeIcon className="w-3.5 h-3.5" /> {regime}
        </span>
    );
};

// ── Stats cell (tipos + servicios horizontal) ─────────────────────────────────
const StatsCell = ({ row }) => {
    const roomCount = (row.room_types ?? row.roomTypes)?.length ?? 0;
    const serviceCount = Array.isArray(row.features) ? row.features.length : 0;
    return (
        <div className="flex flex-wrap justify-center gap-1.5">
            <span className="inline-flex items-center gap-1 text-[11px] text-[#001f6c]/70 bg-[#f4f7fb] px-2 py-0.5 rounded-full border border-[#001f6c]/10 whitespace-nowrap">
                <BedIcon className="w-3.5 h-3.5" /> {roomCount} tipo{roomCount !== 1 ? 's' : ''}
            </span>
            <span className="inline-flex items-center gap-1 text-[11px] text-[#001f6c]/70 bg-[#f4f7fb] px-2 py-0.5 rounded-full border border-[#001f6c]/10 whitespace-nowrap">
                <SparkleIcon className="w-3.5 h-3.5" /> {serviceCount} serv.
            </span>
        </div>
    );
};

// ── Table columns ─────────────────────────────────────────────────────────────
const COLUMNS = [
    { key: 'thumb', label: 'Portada', tdClass: 'px-3 py-2 align-middle w-24', render: (_, row) => <Thumb image={row.post?.thumbnail || row.post?.banner} /> },
    { key: 'post.name', label: 'Nombre', sortable: true },
    { key: 'destination', label: 'Ubicación', sortable: true },
    { key: 'stars', label: 'Cat.', sortable: true, render: (v) => <div className="flex items-center justify-center gap-0.5">{v} <StarIcon weight="fill" className="w-3.5 h-3.5 text-amber-500" /></div> },
    { key: 'starting_price', label: 'Precio/Noche ($)', sortable: true },
    { key: 'regime', label: 'Régimen', render: (_, row) => <RegimeCell row={row} /> },
    { key: 'stats', label: 'Servicios', render: (_, row) => <StatsCell row={row} /> },
    { key: 'isActive', label: 'Activo', sortable: true, render: (v) => v ? <CheckCircleIcon weight="fill" className="w-5 h-5 text-green-500 mx-auto" /> : <XCircleIcon weight="fill" className="w-5 h-5 text-red-500 mx-auto" /> },
];

// ── Steps configuration ───────────────────────────────────────────────────────
const STEPS = [
    { id: 1, label: 'General', icon: <HouseIcon className="w-5 h-5" /> },
    { id: 2, label: 'Imágenes', icon: <ImageIcon className="w-5 h-5" /> },
    { id: 3, label: 'Contenido', icon: <ArticleIcon className="w-5 h-5" /> },
];

// ── Default empty form ────────────────────────────────────────────────────────
const defaultForm = () => ({
    name: '',
    destination: '',
    map_location: '',
    stars: '',
    starting_price: '',
    board_type_FK: '',
    room_types: [],
    isActive: true,
    banner: '',
    thumbnail: '',
    images: [],
    overview: '',
    information: '',
    features: [],
});

// ── Step indicator ────────────────────────────────────────────────────────────
const StepIndicator = ({ current, total }) => (
    <div className="flex items-center gap-0 mb-6">
        {STEPS.map((step, idx) => {
            const done = step.id < current;
            const active = step.id === current;
            const last = idx === STEPS.length - 1;
            return (
                <React.Fragment key={step.id}>
                    <div className="flex flex-col items-center gap-1 min-w-[70px]">
                        <div className={`w-10 h-10 rounded-full flex items-center justify-center text-sm font-bold border-2 transition-all
                            ${done ? 'bg-[#ed6f00] border-[#ed6f00] text-white' : ''}
                            ${active ? 'bg-[#001f6c] border-[#001f6c] text-white ring-4 ring-[#001f6c]/20' : ''}
                            ${!done && !active ? 'bg-white border-gray-200 text-gray-400' : ''}
                        `}>
                            {done ? (
                                <CheckIcon className="w-4 h-4" />
                            ) : (
                                <span className="flex items-center justify-center -translate-y-px">
                                    {step.icon}
                                </span>
                            )}
                        </div>
                        <span className={`text-[11px] font-semibold text-center leading-tight
                            ${active ? 'text-[#001f6c]' : ''}
                            ${done ? 'text-[#ed6f00]' : ''}
                            ${!done && !active ? 'text-gray-400' : ''}
                        `}>
                            {step.label}
                        </span>
                    </div>
                    {!last && (
                        <div className={`flex-1 h-0.5 mb-4 mx-1 rounded transition-all ${done ? 'bg-[#ed6f00]' : 'bg-gray-200'}`} />
                    )}
                </React.Fragment>
            );
        })}
    </div>
);

// ── Hotel Form ────────────────────────────────────────────────────────────────
const HotelForm = ({ lookups, editRow, onSaved, onCancelEdit }) => {
    const [step, setStep] = useState(1);
    const [form, setForm] = useState(defaultForm());
    const [saving, setSaving] = useState(false);
    const isEditing = !!editRow;

    // Pre-fill when editRow changes
    useEffect(() => {
        if (editRow) {
            setForm({
                name: editRow.post?.name || '',
                destination: editRow.destination || '',
                map_location: editRow.map_location || '',
                stars: String(editRow.stars || ''),
                starting_price: String(editRow.starting_price || ''),
                board_type_FK: editRow.board_type_FK != null ? String(editRow.board_type_FK) : '',
                room_types: (editRow.roomTypes || []).map(r => r.room_type_ID),
                isActive: editRow.isActive ?? true,
                banner: editRow.post?.banner || '',
                thumbnail: editRow.post?.thumbnail || '',
                images: (editRow.post?.images || []).map(i => i.url),
                overview: editRow.post?.overview || '',
                information: editRow.post?.information || '',
                features: Array.isArray(editRow.features) ? editRow.features : [],
            });
        } else {
            setForm(defaultForm());
        }
        setStep(1);
    }, [editRow]);

    const set = (k) => (e) =>
        setForm(f => ({ ...f, [k]: e.target.type === 'checkbox' ? e.target.checked : e.target.value }));

    const handleGallery = (urls) => {
        setForm(f => ({ ...f, images: urls }));
    };

    const handleSubmit = async () => {
        setSaving(true);
        const payload = {
            ...form,
            stars: parseInt(form.stars, 10),
            starting_price: parseFloat(form.starting_price),
            board_type_FK: form.board_type_FK || null,
            images: form.images.filter(Boolean),
        };
        try {
            if (isEditing) {
                await api.put(`/accommodations/${editRow.accommodation_ID}`, payload);
                showSuccess('Alojamiento actualizado exitosamente!');
            } else {
                await api.post('/accommodations', payload);
                showSuccess('Alojamiento creado exitosamente!');
            }
            setForm(defaultForm());
            setStep(1);
            if (onSaved) onSaved();
        } catch (err) {
            console.error('Error saving accommodation:', err);
            showError('Error al guardar el alojamiento.');
        } finally {
            setSaving(false);
        }
    };

    const handleCreateRoomType = async (newType) => {
        try {
            const res = await api.post('/lookups/room-types', { type: newType });
            setForm(f => ({ ...f, room_types: [...f.room_types, res.data.room_type_ID] }));
            if (onSaved) onSaved();
        } catch (err) {
            showError('Error al crear tipo de habitación.');
        }
    };

    const handleCreateBoardType = async (newType) => {
        try {
            const res = await api.post('/lookups/board-types', { type: newType });
            // Auto-select the newly created board type
            setForm(f => ({ ...f, board_type_FK: String(res.data.board_type_ID) }));
            if (onSaved) onSaved();
        } catch (err) {
            showError('Error al crear régimen.');
        }
    };

    const handleCancel = () => { setForm(defaultForm()); setStep(1); onCancelEdit(); };

    return (
        <div id="form-hotel">
            {/* Edit mode banner */}
            {isEditing && (
                <div className="mb-3 flex items-center justify-between bg-amber-50 border border-amber-300 rounded-xl px-5 py-3">
                    <div className="flex items-center gap-2 text-amber-700 font-semibold text-sm">
                        <PencilSimpleIcon className="w-5 h-5" />
                        Editando: <span className="font-bold">{editRow?.post?.name}</span>
                    </div>
                    <button type="button" onClick={handleCancel}
                        className="text-sm text-amber-700 hover:text-red-600 font-bold underline transition-colors">
                        Cancelar edición
                    </button>
                </div>
            )}

            <div className="bg-white rounded-2xl border border-[#ed6f00] shadow-sm overflow-visible">
                {/* Header */}
                <div className="bg-[#f4f7fb] border-b border-[#ed6f00]/30 px-6 py-4">
                    <h2 className="text-lg font-extrabold text-[#001f6c]">
                        {isEditing ? 'Editar Hotel' : 'Crear un Nuevo Hotel'}
                    </h2>
                </div>

                <div className="p-6">
                    {/* Step indicator */}
                    <StepIndicator current={step} total={STEPS.length} />

                    <div>
                        {/* ── Step 1: General Info ─────────────────────────── */}
                        {step === 1 && (
                            <div className="space-y-4 animate-in fade-in slide-in-from-right-4 duration-200">
                                <div className="grid grid-cols-1 lg:grid-cols-2 gap-4">
                                    <FormInput label="Nombre del Hotel" id="ht-nombre"
                                        value={form.name} onChange={set('name')} required />
                                    <FormInput label="Ubicación / Ciudad" id="ht-ubicacion"
                                        value={form.destination} onChange={set('destination')} required />
                                </div>

                                <div className="grid grid-cols-2 gap-4">
                                    <FormSelect label={<span className="flex items-center gap-1">Categoría <StarIcon weight="fill" className="w-3 h-3 text-amber-500" /></span>} id="ht-categoria"
                                        options={[
                                            { value: '1', label: '1 ★' },
                                            { value: '2', label: '2 ★' },
                                            { value: '3', label: '3 ★' },
                                            { value: '4', label: '4 ★' },
                                            { value: '5', label: '5 ★' },
                                        ]}
                                        value={form.stars} onChange={set('stars')} required />
                                    <FormInput label="Precio / Noche ($)" id="ht-precio"
                                        type="number" min="0" step="0.01"
                                        value={form.starting_price} onChange={set('starting_price')} required />
                                </div>

                                <FormPlaceSearch
                                    label="Ubicación en Maps"
                                    id="ht-map_location"
                                    value={form.map_location}
                                    onChange={set('map_location')}
                                    category="hotel"
                                />

                                <div className="grid grid-cols-1 lg:grid-cols-2 gap-4">
                                    <FormSelectCreatable label="Régimen (Opcional)" id="ht-board"
                                        options={lookups.boardTypes.map(b => ({ value: b.board_type_ID, label: boardLabel(b.type) }))}
                                        value={form.board_type_FK} onChange={set('board_type_FK')}
                                        onCreateOption={handleCreateBoardType} />
                                    <FormMultiSelect
                                        label="Tipos de Habitación" id="ht-room"
                                        options={lookups.roomTypes.map(r => ({ value: r.room_type_ID, label: r.type }))}
                                        value={form.room_types}
                                        onChange={(arr) => setForm(f => ({ ...f, room_types: arr }))}
                                        onCreateOption={handleCreateRoomType}
                                    />
                                </div>

                                <FormCheckbox label="Hotel Activo" id="ht-activo"
                                    checked={form.isActive} onChange={set('isActive')} />
                            </div>
                        )}

                        {/* ── Step 2: Images ───────────────────────────────── */}
                        {step === 2 && (
                            <div className="space-y-5 animate-in fade-in slide-in-from-right-4 duration-200">
                                <div className="grid grid-cols-1 lg:grid-cols-2 gap-4">
                                    <div className="space-y-4">
                                        <FormImageUpload label="URL del Banner" id="ht-banner" value={form.banner} onChange={set('banner')} />
                                        <FormImageUpload label="URL del Thumbnail" id="ht-thumbnail" value={form.thumbnail} onChange={set('thumbnail')} />
                                    </div>
                                    <div className="space-y-2">
                                        {/* Live preview */}
                                        {(form.banner || form.thumbnail) && (
                                            <div className="flex gap-3 mb-2">
                                                {form.banner && (
                                                    <div className="flex-1">
                                                        <p className="text-[10px] font-semibold text-[#001f6c]/60 uppercase mb-1">Banner</p>
                                                        <img src={getImageUrl(form.banner)} alt="Banner preview"
                                                            className="w-full h-24 object-cover rounded-lg border border-gray-200"
                                                            onError={(e) => { e.target.style.display = 'none'; }} />
                                                    </div>
                                                )}
                                                {form.thumbnail && (
                                                    <div className="w-24">
                                                        <p className="text-[10px] font-semibold text-[#001f6c]/60 uppercase mb-1">Thumbnail</p>
                                                        <img src={getImageUrl(form.thumbnail)} alt="Thumbnail preview"
                                                            className="w-24 h-24 object-cover rounded-lg border border-gray-200"
                                                            onError={(e) => { e.target.style.display = 'none'; }} />
                                                    </div>
                                                )}
                                            </div>
                                        )}
                                    </div>
                                </div>

                                <div className="flex flex-col gap-1">
                                    <FormGalleryUpload label="URLs de Galería" id="ht-images" value={form.images} onChange={handleGallery} />
                                </div>

                                {/* Gallery preview chips */}
                                {form.images.length > 0 && (
                                    <div className="grid grid-cols-3 sm:grid-cols-6 gap-2">
                                        {form.images.map((url, i) => (
                                            <img key={i} src={getImageUrl(url)} alt={`Galería ${i + 1}`}
                                                className="h-16 w-full object-cover rounded-lg border border-gray-200"
                                                onError={(e) => { e.target.style.opacity = '0.3'; }} />
                                        ))}
                                    </div>
                                )}
                            </div>
                        )}

                        {/* ── Step 3: Content & Features ───────────────────── */}
                        {step === 3 && (
                            <div className="space-y-5 animate-in fade-in slide-in-from-right-4 duration-200">
                                <div className="grid grid-cols-1 lg:grid-cols-2 gap-6">
                                    <div className="space-y-4">
                                        <FormTextarea
                                            label="Resumen corto (para tarjetas y listados)"
                                            id="ht-overview" rows={3}
                                            value={form.overview} onChange={set('overview')}
                                            placeholder="Breve descripción visible en tarjetas..."
                                        />
                                        <FormTextarea
                                            label="Descripción completa (página de detalle)"
                                            id="ht-info" rows={6}
                                            value={form.information} onChange={set('information')}
                                            placeholder="Descripción completa del hotel..."
                                        />
                                    </div>
                                    <FormFeatureList
                                        label="Servicios y Amenidades"
                                        id="ht-features"
                                        value={form.features}
                                        onChange={(arr) => setForm(f => ({ ...f, features: arr }))}
                                    />
                                </div>
                            </div>
                        )}

                        {/* ── Navigation buttons ───────────────────────────── */}
                        <div className="flex items-center justify-between mt-8 pt-5 border-t border-gray-100">
                            <button
                                type="button"
                                onClick={() => setStep(s => Math.max(1, s - 1))}
                                disabled={step === 1}
                                className="flex items-center gap-2 px-5 py-2.5 rounded-xl border border-gray-200 text-sm font-semibold text-[#001f6c]/60 hover:border-[#001f6c]/30 hover:text-[#001f6c] disabled:opacity-30 disabled:cursor-not-allowed transition-all"
                            >
                                <ArrowLeftIcon className="w-4 h-4" />
                                Anterior
                            </button>

                            <div className="flex items-center gap-2">
                                {STEPS.map(s => (
                                    <button key={s.id} type="button"
                                        onClick={() => setStep(s.id)}
                                        className={`w-2 h-2 rounded-full transition-all ${step === s.id ? 'bg-[#001f6c] w-4' : step > s.id ? 'bg-[#ed6f00]' : 'bg-gray-200'}`}
                                    />
                                ))}
                            </div>

                            {step < STEPS.length ? (
                                <button
                                    type="button"
                                    onClick={() => setStep(s => Math.min(STEPS.length, s + 1))}
                                    className="flex items-center gap-2 px-5 py-2.5 rounded-xl bg-[#001f6c] text-white text-sm font-semibold hover:bg-[#001f6c]/90 transition-all shadow-sm"
                                >
                                    Siguiente
                                    <ArrowRightIcon className="w-4 h-4" />
                                </button>
                            ) : (
                                <button
                                    type="button"
                                    onClick={handleSubmit}
                                    disabled={saving}
                                    className="flex items-center gap-2 px-8 py-2.5 rounded-xl bg-[#ed6f00] text-white text-sm font-bold hover:bg-[#ed6f00]/90 disabled:opacity-60 disabled:cursor-not-allowed transition-all shadow-sm"
                                >
                                    {saving ? (
                                        <>
                                            <div className="w-4 h-4 border-2 border-white border-t-transparent rounded-full animate-spin" />
                                            Guardando...
                                        </>
                                    ) : (
                                        <>
                                            <CheckIcon className="w-4 h-4" />
                                            {isEditing ? 'Guardar Cambios' : 'Crear Hotel'}
                                        </>
                                    )}
                                </button>
                            )}
                        </div>
                    </div>
                </div>
            </div>
        </div>
    );
};

// ── Page ──────────────────────────────────────────────────────────────────────
const Hoteles = () => {
    useDocumentTitle('Hoteles');
    const [accommodations, setAccommodations] = useState([]);
    const [lookups, setLookups] = useState({ boardTypes: [], roomTypes: [] });
    const [loading, setLoading] = useState(true);
    const [editRow, setEditRow] = useState(null);

    const fetchData = async () => {
        try {
            setLoading(true);
            const [accRes, lookupsRes] = await Promise.all([
                api.get('/accommodations'),
                api.get('/lookups'),
            ]);
            const flat = accRes.data.map(acc => ({ ...acc, 'post.name': acc.post?.name }));
            setAccommodations(flat);
            setLookups({
                boardTypes: lookupsRes.data.board_types || [],
                roomTypes: lookupsRes.data.room_types || [],
            });
        } catch (err) {
            console.error('Error fetching accommodations:', err);
        } finally {
            setLoading(false);
        }
    };

    useEffect(() => { fetchData(); }, []);

    const handleEdit = (row) => {
        setEditRow(row);
        setTimeout(() => {
            document.getElementById('form-hotel')?.scrollIntoView({ behavior: 'smooth', block: 'start' });
        }, 50);
    };

    const handleArchive = async (row) => {
        const name = row['post.name'] || row.post?.name || 'este alojamiento';
        if (!await showConfirm(`¿Eliminar "${name}"? Esta acción no se puede deshacer.`)) return;
        try {
            await api.delete(`/accommodations/${row.accommodation_ID}`);
            fetchData();
        } catch (err) {
            console.error('Error deleting accommodation:', err);
            showError('Error al eliminar el alojamiento.');
        }
    };

    return (
        <div className="p-6 space-y-8 animate-in fade-in duration-300">
            {loading ? (
                <div className="flex justify-center p-10">
                    <div className="animate-spin h-8 w-8 border-b-2 border-[#ed6f00] rounded-full" />
                </div>
            ) : (
                <AdminTable
                    title="Alojamientos"
                    newLabel="Nuevo Alojamiento"
                    columns={COLUMNS}
                    data={accommodations}
                    pageSize={10}
                    onNew={() => { setEditRow(null); document.getElementById('form-hotel')?.scrollIntoView({ behavior: 'smooth' }); }}
                    onView={(row) => showInfo(`Vista previa: ${row['post.name']}`)}
                    onEdit={handleEdit}
                    onArchive={handleArchive}
                />
            )}

            <HotelForm
                lookups={lookups}
                editRow={editRow}
                onSaved={() => { setEditRow(null); fetchData(); }}
                onCancelEdit={() => setEditRow(null)}
            />
        </div>
    );
};

export default Hoteles;
