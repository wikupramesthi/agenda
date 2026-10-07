import { FormEvent, useState } from "react";

export function ContactPage() {
  const [sent, setSent] = useState(false);
  const submit = (event: FormEvent<HTMLFormElement>) => {
    event.preventDefault();
    setSent(true);
    event.currentTarget.reset();
  };
  return (
    <>
      <section className="contact-react ui-section ui-section-top"><div className="ui-wrap"><div className="ui-sec-head"><h1 className="ui-sec-title ink-blue">KONTAK</h1><p className="ui-sec-desc">Butuh bantuan cepat? Hubungi Call Center (021) 82678824 atau kirim pesan melalui formulir di bawah ini.</p></div><div className="contact-react-grid"><div><h2>DBMSDA Kota Bekasi</h2><p>Jl. H. Djaini, RT.007/RW.001, Bojong Rawalumbu, Kec. Rawalumbu, Kota Bekasi, Jawa Barat 17116</p><p><b>Call Center</b><br /><a href="tel:02182678824">(021) 82678824</a></p><p><b>Email</b><br />dbmsdakotabekasi2018@gmail.com</p></div><form onSubmit={submit} autoComplete="off"><label>Nama<input required maxLength={80} name="name" autoComplete="name" /></label><label>Email<input required maxLength={120} name="email" type="email" autoComplete="email" /></label><label>Pesan<textarea required maxLength={1000} name="message" rows={6} /></label><button className="fill-blue" type="submit">KIRIM PESAN <span aria-hidden="true">›</span></button>{sent && <p role="status">Simulasi selesai. Data tidak dikirim atau disimpan.</p>}</form></div></div></section>
    </>
  );
}
