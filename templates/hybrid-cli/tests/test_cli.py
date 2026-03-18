from __future__ import annotations

from __MODULE_NAME__.cli import main


def test_main_runs(monkeypatch, capsys):
    monkeypatch.setattr("sys.argv", ["__APP_NAME__", "--format", "json"])
    code = main()
    out = capsys.readouterr().out

    assert code == 0
    assert '"tool": "__APP_NAME__"' in out
